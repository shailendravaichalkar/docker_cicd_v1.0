def remote = [:]
remote.name = "node"
remote.host = "devopslinux"
remote.allowAnyHosts = true

node {
    withCredentials([usernamePassword(credentialsId: 'a72759b4-2f4f-4545-b1f7-db1fa4e6f977', passwordVariable: 'password', usernameVariable: 'userName')]) {
        remote.user = userName
        remote.password = password
        stage("BUILD") {
            sshCommand remote: remote, command: "id"
            sshCommand remote: remote, command: "pwd"
        }
        stage("Deploy") {
            sshCommand remote: remote, command: "id"
            sshCommand remote: remote, command: "pwd"
        }
        stage("Post 2") {
            echo "Mail Sent Successful"
        }
    }
}
