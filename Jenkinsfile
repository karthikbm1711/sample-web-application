pipeline {
   agent any
      stages {
          stage('sonar quality check'){
            agent{
             docker{
                image 'maven:latest'
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
