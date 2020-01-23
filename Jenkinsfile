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
    image: danielrmartin/sko:latest
    command: ['cat']
    tty: true
"""
    }
  }
  stages {
    stage('Run maven') {
      steps {
        container('maven') {
          sh ' mvn deploy -f ./complete/pom.xml'
        }
      }
    }
    stage ('Run SonarQube'){
      stpes{
        container('maven'){
          sh 'mvn sonar:sonar'
        }}}
  }
}
