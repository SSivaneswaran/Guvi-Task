#! /bin/bash

echo "This is shivas simple script and ran through Jenkins with Git "
emailext body: 'Email sent from Shive-Jenkins', subject: 'Shive-Jenkins', to: 'ssivaneswaran@gmail.com'
