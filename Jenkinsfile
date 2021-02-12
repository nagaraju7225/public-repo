pipeline {
	agent any
	environment {
		NAME = 'Nagaraju'
	}
	stages {
		stage('Stage1') { 
			steps { 
				sh "echo 'Your name: $NAME'"
			}
		}
		stage('stage2') { 
			steps { 
				echo env.NAME
			}
		}
		
	}
}
