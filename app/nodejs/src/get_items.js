const { DynamoDBClient, ScanCommand } = require("@aws-sdk/client-dynamodb");

const client = new DynamoDBClient({
  region: process.env.REGION,
});

exports.handler = async (event) => {
  console.log(event);

  const request = new ScanCommand({
    TableName: process.env.TABLE,
  });

  const result = await client.send(request);

  return {
    statusCode: 200,
    body: JSON.stringify(result.Items),
  };
};
