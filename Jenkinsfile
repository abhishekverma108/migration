pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('00fe45-19-4fa-b5e-fc9753abe81')
        AWS_SECRET_ACCESS_KEY = credentials('115f18-104-4ca-be7-2fae54c27fd')
        
    }
    
    stages {
        stage("Creating Instance on Aws From Terraform"){
            steps{
                sh 'sudo terraform -chdir=/terra_code/ init'
                sh 'sudo terraform -chdir=/terra_code/ apply -auto-approve'
            }
        }
        stage('Deploy') {
            steps {
                script{
                    def user_input = input (message: 'Enter a value:', parameters: [
                        string(name: 'USER_INPUT', defaultValue: 'default_value', description: 'Enter a value')
                    ]
                    )
                    echo "The user input is: ${user_input}"
                    sh 'export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID'
                    sh 'export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY'
                    ansiblePlaybook credentialsId: 'privatekey',  extraVars: [my_param: user_input], disableHostKeyChecking: true, installation: 'ansible', inventory: '/inter_project/aws_ec2.yml', playbook: '/inter_project/migration.yml'
                }
            }
        }
    }
}
