pipeline {
    agent any

    tools {
        maven 'maven'
    }

    stages {
        stage('Checkout'){
            steps {
                git branch: 'feature/practice-vasanth', credentialsId: 'github', url: 'https://github.com/vasanthkumar13m/spring-petclinic.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }

        }
        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
        stage('Deploy To EC2') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ec2-instance', transfers: [sshTransfer(sourceFiles: 'target/*.jar', removePrefix: 'target', remoteDirectory:'/app')])])
            }
        }
    }
}
post {

        success {
            emailext(
                subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Build Successful

Job Name : ${env.JOB_NAME}
Build No : ${env.BUILD_NUMBER}

Build URL:
${env.BUILD_URL}

JAR File Created Successfully.
""",
                to: 'somisettyvasanthkumar@gmail.com'
            )
        }

        failure {
            emailext(
                subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Build Failed

Job Name : ${env.JOB_NAME}
Build No : ${env.BUILD_NUMBER}

Check Console:
${env.BUILD_URL}
""",
                to: 'somisettyvasanthkumar@gmail.com'
            )
        }
    }
}