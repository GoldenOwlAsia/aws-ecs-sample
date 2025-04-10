pipeline {
    agent any
    
    environment {
        AWS_ACCOUNT_ID = credentials('HCMUS_SEMINAR_AWS_ACCOUNT_ID')
        AWS_REGION = 'ap-southeast-1'
        AWS_ACCESS_KEY_ID = credentials('HCMUS_SEMINAR_AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('HCMUS_SEMINAR_AWS_SECRET_ACCESS_KEY')
        ECR_REPOSITORY = credentials('HCMUS_SEMINAR_ECR_REPOSITORY')
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        DOCKER_IMAGE = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}"
        DOCKERFILE = 'Dockerfile'
        ECS_CLUSTER = credentials('HCMUS_SEMINAR_ECS_CLUSTER')
        ECS_SERVICE = credentials('HCMUS_SEMINAR_ECS_SERVICE')
    }
    
    stages {
        stage('Code Checkout') {
            steps {
                checkout scm
                echo "Code checked out successfully"
            }
        }
        
        stage('Static Code Analysis') {
            steps {
                echo "Running SonarQube analysis..."
                // Mock SonarQube scan
                sh 'echo "SonarQube analysis completed"'
            }
        }
        
        stage('Unit Tests') {
            steps {
                echo "Running unit tests..."
                // Mock unit tests
                sh 'echo "Unit tests passed"'
            }
        }
        
        stage('Dependency Check') {
            steps {
                echo "Scanning dependencies for vulnerabilities..."
                // Mock OWASP dependency check
                sh 'echo "Dependency check completed"'
            }
        }
        
        stage('Build Docker Image') {
            // when {
            //     branch 'main'
            // }
            steps {
                echo "Building Docker image: ${DOCKER_IMAGE}"
                withCredentials([file(credentialsId: 'HCMUS_SEMINAR_ENV_FILE', variable: 'ENV_FILE')]) {
                    sh """
                        cd source_code
                        cat ${ENV_FILE} > .env
                        docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} -t ${DOCKER_IMAGE}:latest -f ${env.DOCKERFILE} .
                        rm -f .env
                    """
                }
            }
        }
        
        stage('Container Security Scan') {
            steps {
                echo "Scanning Docker image for vulnerabilities..."
                // Mock Trivy container scan
                sh 'echo "Container security scan passed"'
            }
        }
        
        stage('Push to ECR') {
            // when {
            //     branch 'main'
            // }
            steps {
                echo "Pushing Docker image to ECR..."
                sh '''
                    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    docker push ${DOCKER_IMAGE}
                '''
                echo "Image pushed to ECR successfully"
            }
        }
        
        // stage('Deploy to ECS') {
        //     // when {
        //     //     branch 'main'
        //     // }
        //     steps {
        //         echo "Deploying to ECS cluster: ${ECS_CLUSTER}, service: ${ECS_SERVICE}"
        //         sh '''
        //             aws ecs update-service --cluster ${ECS_CLUSTER} --service ${ECS_SERVICE} --force-new-deployment
        //             echo "Waiting for service to stabilize..."
        //             aws ecs wait services-stable --cluster ${ECS_CLUSTER} --services ${ECS_SERVICE}
        //         '''
        //         echo "Deployment to ECS completed successfully"
        //     }
        // }
        
        stage('Integration Tests') {
            steps {
                echo "Running integration tests against deployed application..."
                // Mock integration tests
                sh 'echo "Integration tests passed"'
            }
        }
        
        stage('Performance Tests') {
            steps {
                echo "Running performance tests..."
                // Mock JMeter or Gatling tests
                sh 'echo "Performance tests completed"'
            }
        }
    }
    
    post {
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed. Sending notifications..."
            // Mock notification system
            sh 'echo "Notification sent"'
        }
        always {
            echo "Cleaning up resources..."
            sh 'docker rmi ${DOCKER_IMAGE} || true'
        }
    }
}