function sum(){

    URL=$1

    #echo "URL: $URL";

    TEXT=$(lynx -notitle -nonumbers -trim_input_fields -nobrowse -hiddenlinks=ignore --dump $URL | xargs | sed -e 's!http\(s\)\{0,1\}://[^[:space:]]*!!g' | sed -e 's/\[[^][]*\]//g')
    DEEP_API_KEY="a2de657c-75d0-4a7c-acdf-3b886f860282"

    #echo "--------------------";
    #echo $TEXT
    #echo "--------------------";

    RESULT_JSON=$(curl --silent -F "text=$TEXT" -H "api-key:$DEEP_API_KEY" https://api.deepai.org/api/summarization )

    #echo "JSON: $RESULT_JSON"

    RESULT=$(echo $RESULT_JSON | tr '\r\n' ' ' | jq ".output")

    echo $RESULT

}
