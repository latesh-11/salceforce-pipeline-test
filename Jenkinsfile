pipeline{
    agent {
      node {
             label 'test'
        }
    }

    environment{
        PR_CREDENTIALS_ID = "PR_CONSUMER_KEY"
        PATH = "${env.PATH}:~/cli/sf/bin"
    }

    stages{
        stage("Code analysis"){
            steps{
                script {
                    sh "chmod +x  bashScripts/countError.sh"
                    sh "./bashScripts/countError.sh"
                    echo "PMD Script - Commit at develop"
                }
            }
        }
        stage("Validate"){
           steps {
                script {
                     if (env.CHANGE_ID != null){
                        if (env.CHANGE_TARGET == 'QA') {
                            withCredentials([usernamePassword(credentialsId: "${PR_CREDENTIALS_ID}", passwordVariable: 'PR_CONSUMER_KEY', usernameVariable: 'PR_USERNAME')]) {
                                echo "  "
                                echo "Authenticating in Production.... ⏱️"
                                echo " "
                                sh """
                                    sf -v
                                    sf login org jwt --alias PR --client-id ${PR_CONSUMER_KEY} --jwt-key-file  accesskey/server.key --set-default --set-default-dev-hub --instance-url https://login.salesforce.com --username ${PR_USERNAME}
                                    echo "Successfully authenticated in Production ✅"
                                    echo "Validation started ... 🔜"
                                    sf project deploy start -x  manifest/package.xml --dry-run --target-org PR --ignore-warnings --verbose
                                """
                            }
                        }
                    }
                }
           }
        }
        stage("Deploy"){
           steps {
                script {
                        if (env.BRANCH_NAME == 'QA') {
                            withCredentials([usernamePassword(credentialsId: "${PR_CREDENTIALS_ID}", passwordVariable: 'PR_CONSUMER_KEY', usernameVariable: 'PR_USERNAME')]) {
                                echo "  "
                                echo "Authenticating in Production.... ⏱️"
                                echo " "
                                sh """
                                    sf login org jwt --alias PR --client-id ${PR_CONSUMER_KEY} --jwt-key-file  accesskey/server.key --set-default --set-default-dev-hub --instance-url https://login.salesforce.com --username ${PR_USERNAME}
                                    echo "Successfully authenticated in Production ✅"
                                    echo "Deployment started ... 🔜"
                                    sf project deploy start -x  manifest/package.xml --target-org PR --ignore-warnings --verbose
                                """
                            }
                        }
                }
           }
        }
    }
}



