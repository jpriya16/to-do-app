pipeline {  
    agent any  
    parameters {
        booleanParam(defaultValue: true, description: '', name: 'Build')
    }
    stages {
        stage ('Build') {  
            when { expression { return params.Build }} 
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh "docker build -t ${user}/to-do-app:${currentBuild.number} ."
                    sh "docker tag ${user}/to-do-app:${currentBuild.number} ${user}/to-do-app:latest"
                }
            }
        }
        stage ('Push to registry') {
            when { expression { return params.Build }} 
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh "docker login -u ${user} -p ${pass}"
                    sh "docker push ${user}/to-do-app:${currentBuild.number}"
                    sh "docker push ${user}/to-do-app:latest"
                }
            }
        }

    }
    }
    