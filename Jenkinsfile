pipeline {
    agent any
    parameters {
        booleanParam(defaultValue: true, description: '', name: 'Build')
    }
    stages {
        stage ('Build') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh "aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/z6b8a8c7"
                    sh "docker build -t to-do-app ."
                    sh "docker tag to-do-app:latest public.ecr.aws/z6b8a8c7/to-do-app:latest"

                }
            }
        }
        stage ('Push to registry') {
            when { expression { return params.Build }}
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh "docker push public.ecr.aws/z6b8a8c7/to-do-app:latest"
                 }
            }
        }
    }
