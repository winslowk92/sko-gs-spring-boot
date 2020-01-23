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
    image: danielrmartin/sko:1.0
    command: ['cat']
    tty: true
"""
    }
  }
  stages {
    stage('Run maven') {
      steps {
        container('maven') {
          sh ''' sleep 60
          mvn deploy -f ./complete/pom.xml'''
        }
      }
    }
    stage ('Run SonarQube'){
      steps{
        container('maven'){
          sh 'mvn sonar:sonar'
        }}}
  }
}
