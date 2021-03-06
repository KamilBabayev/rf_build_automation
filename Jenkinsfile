#!groovy
def rev 
node('dockerbuildnode') {
  stage('Checkout') {
    checkout scm
    rev  = "$BUILD_NUMBER"
  }

  stage('Syntax') {
    echo "${rev}: Syntax and Lint testing"
    sh "true"
  }

  stage('Build robot-framework') {
    echo "${rev}: Building container from Dockerfile"
    sh "sudo docker build -t robot-framework:$rev ."
  }
 
  stage('Test') {
    echo  "${rev}: Testing"
    sh "true"
  }

  stage('Approve') {
    echo  "${rev}: Waiting for approval for change"
    input "Do you want to upload the image to docker registry and push changes to git"
  }

  stage('Git push') {
    echo "${rev}: Publishing image for community usage"
    def repo = 'git@github.com:Juniper-PS-Automation/26635-ATTM-EDI.git'
    publish_repo_to_subdirectory(repo,'docker/robot-framework','jenkins', rev)
  }


  stage('Upload to registry') {
	sh "true"
  }
}

def publish_repo_to_subdirectory(destrepo,subdirectory,branch,buildnumber) {
   def repodir = getrepodir(destrepo)
   sh "mkdir -p ../builds/build${buildnumber}"
   sh "cd       ../builds/build${buildnumber}; git clone ${destrepo}"
   sh "cd       ../builds/build${buildnumber}/${repodir}; git checkout -b ${branch}"
   sh "mkdir -p ../builds/build${buildnumber}/${repodir}/${subdirectory}"
   sh "cp -r *  ../builds/build${buildnumber}/${repodir}/${subdirectory}"
   sh "cd       ../builds/build${buildnumber}/${repodir}; git add .; git commit -m 'Jenkins build $buildnumber'; git pull origin master; git push -f origin ${branch}"
   sh "rm -rf   ../builds/build${buildnumber}/${repodir}"
}

def getrepodir(repo) {
   def matcher = repo =~ '/([^/]+).git'
   matcher ? matcher[0][1] : null
} 
