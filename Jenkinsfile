pipeline {
  agent any
  parameters {
    choice(name: 'ACTION', choices: ['dev-apply', 'prod-apply'], description: 'Choose Environment')
  }
  stages {
    stage('VPC Apply') {
      steps {
        sh '''
          cd vpc
          make ${ACTION}
        '''
      }
    }
    stage('DB & ALB Apply') {
      parallel {
        stage('DB Apply') {
          steps {
            sh '''
          cd databases
          make ${ACTION}
        '''
          }
        }
        stage('ALB Apply') {
          steps {
            sh '''
          cd alb
          make ${ACTION}
        '''
          }
        }
      }
    }

    stage('Components Apply') {
      parallel {
        stage('Cart Apply') {
          steps {
            dir('cart') {
              sh '''
                  git clone https://chavitisathish@dev.azure.com/chavitisathish/devops-project/_git/cart .
                  cd terraform-mutable
                  make ${ACTION}
                '''
            }
          }
        }
        stage('Catalogue Apply') {
          steps {
            dir('catalogue') {
              sh '''

                git clone https://chavitisathish@dev.azure.com/chavitisathish/devops-project/_git/catalogue .
                cd terraform-mutable
                make ${ACTION}
              '''
            }
          }
        }
        stage('User Apply') {
          steps {
            dir('user') {
              sh '''
                git clone https://chavitisathish@dev.azure.com/chavitisathish/devops-project/_git/user .
                cd terraform-mutable
                make ${ACTION}
              '''
            }
          }
        }
        stage('Payment Apply') {
          steps {
            dir('payment') {
              sh '''
                git clone https://chavitisathish@dev.azure.com/chavitisathish/devops-project/_git/payment .
                cd terraform-mutable
                make ${ACTION}
            '''
            }
          }
        }
        stage('Shipping Apply') {
          steps {
            dir('shipping') {
              sh '''
                git clone https://chavitisathish@dev.azure.com/chavitisathish/devops-project/_git/shipping .
                cd terraform-mutable
                make ${ACTION}
              '''
            }
          }
        }
        stage('Frontend Apply') {
          steps {
            dir('frontend') {
              sh '''
                git clone https://chavitisathish@dev.azure.com/chavitisathish/devops-project/_git/frontend .
                cd terraform-mutable
                make ${ACTION}
              '''
            }
          }
        }

      }
    }

  }

  post {
    always {
      cleanWs()
    }
  }

}


