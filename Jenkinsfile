// Jenkinsfile (Declarative Pipeline)
pipeline {
    // Agent specifies where the entire Pipeline, or a specific stage, will execute.
    // 'any' means it can run on any available agent.
    agent any

    // Environment variables that will be available throughout the pipeline.
    environment {
        // Your Docker Hub username.
        DOCKERHUB_USERNAME = 'tettolizer' 
        // The name for your Docker image.
        IMAGE_NAME = 'simple-node-app'
    }

    stages {
        // Stage 1: Build Docker Image
        // This stage builds the Docker image using the Dockerfile in your repository.
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building the Docker image..."
                    // The 'docker.build' command builds an image. 
                    // The tag includes your Docker Hub username and the image name.
                    docker.build("${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${env.BUILD_NUMBER}", ".")
                }
            }
        }
        
        // Stage 2: Push Docker Image to Docker Hub
        // This stage pushes the built image to Docker Hub.
        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "Pushing the Docker image to Docker Hub..."
                    // 'docker.withRegistry' handles authentication with your Docker registry.
                    // The first argument is the registry URL (leave empty for Docker Hub).
                    // The second is the ID of the credentials you stored in Jenkins.
                    docker.withRegistry('', 'dockerhub-credentials') {
                        // Push the image with the build number as the tag.
                        docker.image("${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                        
                        // Also push the image with the 'latest' tag.
                        docker.image("${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${env.BUILD_NUMBER}").push("latest")
                    }
                }
            }
        }

        // Stage 3: Clean up
        // This stage removes the Docker image from the local Jenkins server to save space.
        stage('Clean up') {
            steps {
                script {
                    echo "Cleaning up local Docker image..."
                    // Remove the Docker image created during the build.
                    // Using 'sh' is often more reliable for cleanup.
                    bat "docker rmi ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${env.BUILD_NUMBER}"
                }
            }
        }
    }
    
    // Post-build actions that run after all stages are complete.
    post {
        // 'always' will run regardless of the pipeline's success or failure.
        always {
            echo 'Pipeline finished.'
        }
        // 'success' runs only if the pipeline is successful.
        success {
            echo 'Pipeline executed successfully!'
        }
        // 'failure' runs only if the pipeline fails.
        failure {
            echo 'Pipeline failed.'
        }
    }
}
