pipeline{
    agent {label 'Bastion'}
    options{
        buildDiscarder(logRotator(daysToKeepStr: '7'))
        disableConcurrentBuilds()
        timeout(time: 10, unit : 'MINUTES')
    
    }
    stages {
        stage('Build Docker Image') {
        steps {
            sh 'rm -rf Final-assignment'
            sh 'git clone https://github.com/devopsaruba/Final-assignment.git'
            sh 'cd Final-assignment && docker build -t final-assignment . && docker tag final-assignment:latest 889521077131.dkr.ecr.us-east-1.amazonaws.com/final-assignment:${BUILD_NUMBER}'
            sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 889521077131.dkr.ecr.us-east-1.amazonaws.com'
            sh 'docker push 889521077131.dkr.ecr.us-east-1.amazonaws.com/final-assignment:${BUILD_NUMBER}'
            }
        }     
        stage('CD using app maachine') {
        steps {
            sh 'ssh -o StrictHostKeyChecking=no -i key.pem ubuntu@10.0.2.57'
			      sh 'sudo su jenkins'
            sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 889521077131.dkr.ecr.us-east-1.amazonaws.com'
            sh 'docker pull 889521077131.dkr.ecr.us-east-1.amazonaws.com/final-assignment:${BUILD_NUMBER}
			      sh 'docker run -itd -p 8081:8081 889521077131.dkr.ecr.us-east-1.amazonaws.com/final-assignment:${BUILD_NUMBER}'
            sh 'docker ps'
            }

        }    

    }
}
