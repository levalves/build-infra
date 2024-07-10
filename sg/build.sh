#!/bin/bash
set -eo pipefail
set -x

if [ ! -d "$PWD/build-tools" ]; then
   git clone --single-branch --branch v1 https://token:$GIT_TOKEN@dev.azure.com/Itsseg/Portal-Beneficios-v2/_git/build-tools "$PWD/build-tools"
fi

__BUILD_TOOLS_PATH="./build-tools"

LOG_FILE="$PWD/build.log"
rm -f $LOG_FILE

source "$__BUILD_TOOLS_PATH/scripts/log.sh"
source "$__BUILD_TOOLS_PATH/scripts/shell_overrides.sh"
source "$__BUILD_TOOLS_PATH/scripts/terraform.sh"
source "$__BUILD_TOOLS_PATH/scripts/aws_credentials.sh"

COMMIT_HASH=${COMMIT_HASH:-$(git log --pretty=format:%h -n 1)}

f_log "COMMIT_HASH is set to $COMMIT_HASH"
export TF_VAR_commit_hash="$COMMIT_HASH"

f_terraform_init() {
  terraform_init $ENV "$PWD/terraform"
}

f_get_region(){
  REGION=$(find . -iname "$ENV.tfvars" | xargs -I {} cat {} | grep -e ^region | cut -d \= -f2 | sed 's/ "//g;s/"//g')
  echo $REGION
} 

f_get_role() {
  if [ "$ENV" == "prd" ]; then
    ROLE="arn:aws:iam::851725266626:role/CrossAccount-itsseg-Prod"
  else
    ROLE="arn:aws:iam::851725266626:role/CrossAccount-itsseg-NonProd"
  fi
  echo $ROLE
}

f_get_account_id(){
  ROLE=$(f_get_role)
  ACCOUNT_ID="$(echo $ROLE | cut -d \: -f5)"
  echo $ACCOUNT_ID
}

f_build_testplan() {
  source ~/.bashrc
  echo $?
  pwd
  echo $PATH
  
  f_get_role
  set_aws_credentials $ROLE
  terraform_testplan $ENV "$PWD/terraform" environments/$ENV.tfvars
  f_terraform_init
}

f_build_plan() {
  f_get_role
  set_aws_credentials $ROLE
  export TF_VAR_build_version=$BUILD_NUMBER
  terraform_plan $ENV "$PWD/terraform" $COMMIT_HASH environments/$ENV.tfvars
}

f_build_apply() {
  f_get_role
  set_aws_credentials $ROLE
  terraform_apply $ENV "$PWD/terraform" $COMMIT_HASH
}

f_destroy_testplan() {
  terraform_destroy_testplan $ENV "$PWD/terraform" environments/$ENV.tfvars
}

f_destroy_plan() {
  terraform_destroy_plan $ENV "$PWD/terraform" $COMMIT_HASH environments/$ENV.tfvars
}

f_destroy_apply() {
  if [ "$ENV" == "prd" ]; then
    f_log "INFO: It seems like you want to destroy a production environment. Please do it manually :-D"
    exit 1
  else
    terraform_destroy $ENV "$PWD/terraform" $COMMIT_HASH
    # f_delete_ecr
  fi
}

case "$1" in
  testplan)
    f_build_testplan
  ;;

  plan)
    f_build_plan
  ;;

  apply)
    f_build_apply
  ;;

  deploy)
    f_build_testplan 
    f_build_plan
    f_build_apply
  ;;

  destroy-testplan)
    f_destroy_testplan
  ;;

  destroy-plan)
    f_destroy_plan
  ;;

  destroy-apply)
    f_destroy_apply
  ;;
  
  *)
    echo "usage: build.sh
    testplan|plan|apply|deploy|destroy-testplan|destroy-plan|destroy-apply"
    exit 0
  ;;

esac
