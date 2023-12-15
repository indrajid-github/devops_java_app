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
    stages
    {
        stage("Cleanup workspace")
        {
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
            steps
            {
                script
                {
                    //Calling shared library
                    mvnIntegration()
                }
            }
        }
    }
}