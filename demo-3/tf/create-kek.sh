set -x 
PROJECT_ID=$1
KEY_ID=$2
TEK=$3
KEK=$4
API_KEY=$5
API_ROOT_URL="https://cloudkms.googleapis.com"
KEK_API="${API_ROOT_URL}/v1/projects/${PROJECT_ID}/locations/global/keyRings/${KEY_ID}:encrypt"
# KEK_API="${API_ROOT_URL}/v1/projects/${PROJECT_ID}/locations/global/keyRings/${KEY_RING_NAME}/cryptoKeys/${KEY_NAME}:encrypt"
curl -X POST -H "Content-Type: application/json" \
 -H "Authorization: Bearer ${API_KEY}" \
 "${KEK_API}"`` \
 -d '{"plaintext":"'${TEK}'"}' \
 -o "${KEK}"	 

# https://github.com/GoogleCloudPlatform/dlp-dataflow-deidentification/blob/master/create-kek.sh