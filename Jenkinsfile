pipeline {
	agent {
		docker {
			image 'maven:3.8.1-adoptopenjdk-11'
				args '-v /root/.m2:/root/.m2'
				}
				}
				stages {
					stage('sonar quality check') {
						steps {
							script {
								withSonarQubeEnv('sonar-server') {
								sh "mvn sonar:sonar"
								}
									timeout(time: 1, unit: 'HOURS') {
                      def qg = waitForQualityGate()
                      if (qg.status != 'OK') {
                           error "Pipeline aborted due to quality gate failure: ${qg.status}"
                      }
                    }
					sh "mvn clean install"
					}
					}
					}
					}
    }
