@Library('my-shared-lib') _

pipeline{
    agent
    {
        label 'maven'
    }
    tools
    {
        maven 'maven3'
    }
    
    parameters
    {
        choice(name: 'activity', choices: ['proceed', 'stop'], description: 'Choose proceed/stop')
        string(name: 'DOCKER_USER', defaultValue: '', description: 'Enter username for dockerhub')
        string(name: 'APP_NAME', defaultValue: '', description: 'Enter application name')
        string(name: 'RELEASE', defaultValue: '', description: 'Enter docker release') 
    }
    environment
    {
        DOCKER_USER = "${params.DOCKER_USER}"
        DOCKER_CRED = "dockerhub"

        APP_NAME = "${params.APP_NAME}"
        RELEASE = "${params.RELEASE}"

        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}" 
    }
    stages
    {
        stage("Cleanup workspace")
        {
            when
            {
                expression { params.activity == 'proceed' }
            }
            steps
            {
                script
                {
                    cleanWs()
                }
            }
        }
        stage("Pulling SC from GIT")
        {
            when
            {
                expression { params.activity == 'proceed' }
            }
            steps
            {
                script
                { 
                    //Calling shared library
                    gitCheckout(
                        branch: "main",
                        url: "https://github.com/indrajid-github/devops_java_app.git"
                    )
                }
            }
        }
        stage("unit test maven")
        {
            when
            {
                expression { params.activity == 'proceed' }
            }
            steps
            {
                script
                {
                    //Calling shared library
                    mvnTest()
                }
            }
        }
        stage("Integration test maven")
        {
            when
            {
                expression { params.activity == 'proceed' }
            }
            steps
            {
                script
                {
                    //Calling shared library
                    mvnIntegration()
                }
            }
        }
        stage("static code analysis: sonarqube")
        {
            when
            {
                expression { params.activity == 'proceed' }
            }
            steps
            {
                script
                {
                    //Calling shared library
                    def sonarqubeCred = 'jenkins-sonar-token'
                    staticCodeAnalysis(sonarqubeCred) 
                }
            }
        }
        stage("quality gate: sonarqube")
        {
            when
            {
                expression { params.activity == 'proceed' }
            }
            steps
            {
                script
                {
                    //Calling shared library
                    def sonarqubeCred = 'jenkins-sonar-token'
                    qualityGate(sonarqubeCred) 
                }
            }
        }
        stage("Application build: Maven")
        {
            when
            {
                expression { params.activity == 'proceed' }
            }
            steps
            {
                script
                {
                    //Calling shared library
                    mvnBuild()
                }
            }
        }
        stage("Docker Build")
        {
            when
            {
                expression { params.activity == 'proceed' }
            }
            steps
            {
                script
                {
                    //Calling shared library
                    withDockerRegistry(credentialsId: DOCKER_CRED) 
                    {
                        docker_image = docker.build("${IMAGE_NAME}")
                    }
                    withDockerRegistry(credentialsId: DOCKER_CRED) 
                    {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push 'latest'
                    }
                }
            }
        }
    }
}