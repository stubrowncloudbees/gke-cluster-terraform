#./create_certs.sh
mypwd=`pwd`
export DOMAIN_NAME=cloudbees.core.pscbdemos.com
cFILE=~/CA/${DOMAIN_NAME}/cert.pem
    echo "checking for ${cFILE}"
if [ ! -e "$cFILE" ]; then
    echo "cert does not exist so creating for ${DOMAIN_NAME}"
    if [ ! -e ./ca/minica ]; then
        echo "unzipping minica"
        unzip ./ca/minica.zip -d ca
    fi
    echo "creating cert and key for ${DOMAIN_NAME}"
    cd ~/CA/;$mypwd/ca/minica -domains ${DOMAIN_NAME}
    cd $mypwd
fi

echo "creating secret for ${DOMAIN_NAME}"

kubectl create secret tls cloudbees-core-tls --key ~/CA/${DOMAIN_NAME}/key.pem --cert ~/CA/${DOMAIN_NAME}/cert.pem --namespace cloudbees-core

