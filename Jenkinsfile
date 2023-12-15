@Library('my-shared-lib') _

pipeline{
    agent
    {
        label 'maven'
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
                    gitCheckout(
                        branch: "main",
                        url: "https://github.com/indrajid-github/devops_java_app.git"
                    )
                }
            }
        }
    }
}