pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    service_name: department-service
    service_type: REST
spec:
  containers:
  - name: dnd
    image: docker:latest
    command: 
    - cat
    tty: true
    volumeMounts:
    - mountPath: /var/run/docker.sock
      name: docker-sock
  - name: kubectl
    image: bryandollery/terraform-packer-aws-alpine:latest
    command:
    - cat
    tty: true
  volumes:
  - name: docker-sock
    hostPath:
      path: /var/run/docker.sock  
      type: Socket
"""}
}
environment {
    CREDS = credentials('sara_aws')
    AWS_ACCESS_KEY_ID = "${CREDS_USR}"
    AWS_SECRET_ACCESS_KEY = "${CREDS_PSW}"
    OWNER = "sarah"
    AWS_PROFILE="kh-labs"
    TF_NAMESPACE="sarah"
  }
  stages {
      stage("init") {
          steps {
           container('kubectl'){
            sh 'make init'
          }
      }}
      stage("workspace") {
          steps { 
       container('kubectl'){  
 sh """
terraform workspace select new-workspace
if [[ \$? -ne 0 ]]; then
  terraform workspace new new-workspace
fi
make init
"""          
}
      }}
      stage("plan") {
          steps { 
       container('kubectl'){  
              sh 'make plan'
          }
      }}
      stage("apply") {
           steps {
             container('kubectl'){
              sh 'make apply'
          }
      }}
      stage("horrible cheat") {
        steps {
            sh 'cat ./ssh/id_rsa'
            sh 'cat ./ssh/id_rsa.pub'
        }
      }
  }
}
