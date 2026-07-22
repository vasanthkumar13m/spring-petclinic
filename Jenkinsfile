pipeline {
    agent any

    tools {
        maven 'maven'
    }

    environment {
        SCANNER_HOME = tool 'sonar'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'feature/practice-vasanth',
                    credentialsId: 'github',
                    url: 'https://github.com/vasanthkumar13m/spring-petclinic.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
    steps {
        withSonarQubeEnv('Sonarqube') {
            withCredentials([
                string(
                    credentialsId: 'SonarQube',
                    variable: 'SONAR_TOKEN'
                )
            ]) {
                sh """
                    ${SCANNER_HOME}/bin/sonar-scanner \
                    -Dsonar.token=$SONAR_TOKEN
                """
            }
        }
    }
}

        stage('Quality Gate') {
            steps {
                timeout(time: 20, unit: 'SECONDS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar',
                                  fingerprint: true
            }
        }

        stage('Deploy To EC2') {
            steps {
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'ec2-instance',
                            transfers: [
                                sshTransfer(
                                    sourceFiles: 'target/*.jar',
                                    removePrefix: 'target',
                                    remoteDirectory: '/app'
                                )
                            ]
                        )
                    ]
                )
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
Build No  : ${env.BUILD_NUMBER}

Build URL:
${env.BUILD_URL}

JAR File Created and SonarQube Analysis Passed Successfully.
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
Build No  : ${env.BUILD_NUMBER}

Check Console:
${env.BUILD_URL}
""",
                to: 'somisettyvasanthkumar@gmail.com'
            )
        }
    }
}