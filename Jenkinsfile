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
                    staticCodeAnalysis()
                }
            }
        }
    }
}