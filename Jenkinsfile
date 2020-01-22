pipeline {
  agent {
    kubernetes {
      //cloud 'kubernetes'
      yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: maven
    image: maven:3.3.9-jdk-8-alpine
    command: ['cat']
    tty: true
"""
    }
  }
  stages {
    stage('Run maven') {
      steps {
        container('maven') {
          sh '''sleep 90
                mvn deploy -f ./complete/pom.xml
                '''
        }
      }
    }
  }
}
