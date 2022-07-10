exports.handler = function(event, context, callback) {

    let body = JSON.parse(event.body)
    console.log(body)

    var response = {
        "statusCode": 200,
        headers: {
            "Access-Control-Allow-Origin": "*",
        }
    }

    // Check if user input is single line
    isSingleLine(body.text).then(isSingle => {
        if (isSingle) {
            isEmail(body.text).then(valid => {
                // Process only if it is a valid email
                if (valid) {
                    response["body"] = "Email is valid!"
                    callback(null, response)
                } else {
                    response["body"] = "Email is invalid!"
                    callback(null, response)
                }
            })
        } else {
            response["body"] = "Please only key in single line input!"
            callback(null, response)
        }
    })  
}

// Check if a email inputted by the user is valid
async function isEmail(str) {
  return str.includes("@")
}

// Check if a email inputted by the user is single line
async function isSingleLine(str) {
    return !str.includes("\n")
}