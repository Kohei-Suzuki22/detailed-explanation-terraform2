# backent.hcl

# tfstateファイルを置くs3バケットを指定
bucket = "detailed-explanation-terraform"
region = "ap-northeast-1"
# lockを管理するdynamo_tableを指定
dynamodb_table = "hello-terraform-remote-state-locks"
encrypt = true