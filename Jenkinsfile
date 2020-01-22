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
    image: sko:latest
    command: ['cat']
    tty: true
"""
    }
  }
  stages {
    stage('Run maven') {
      steps {
        container('maven') {
          sh '''sleep 130
                mvn deploy -f ./complete/pom.xml
                '''
        }
      }
    }
  }
}
