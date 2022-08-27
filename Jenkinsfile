pipeline {
    agent any
        environment {
        VERSION = "${env.BUILD_ID}"
    }
    stages {
        stage('sonar quality check') {
            agent {
                docker {
                    image 'maven:3.8.1-adoptopenjdk-11'


                args '-v /root/.m2:/root/.m2'


                }
            }
            steps {
                script {
                    withSonarQubeEnv('sonar-server') {
                        sh "mvn sonar:sonar"

                                }
                    timeout(time: 1, unit: 'HOURS') {
                        def qg = waitForQualityGate()
                      if (qg.status != 'OK')
                        {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                      }
                    }
                    sh "mvn clean install"


                    }
            }
        }
        stage('docker build and push') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'docker_pass', variable: 'dokcer_password')]) {
                        sh '''
                        docker build -t 44.195.82.28:8083/springapp:${VERSION} .
                        docker login -u admin - p $docker_password 44.195.82.28:8083
                        docker push 44.195.82.28:8083/springapp:${VERSION}
                        docker rmi 44.195.82.28:8083/springapp:${VERSION}
                        '''
                 }
                }

            }
        }
    }
}
