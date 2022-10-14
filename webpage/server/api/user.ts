import type { IncomingMessage, ServerResponse } from "http";

export default async(req: IncomingMessage, res: ServerResponse) => {
    const url = "http://127.0.0.1:5000/users"
    //const Token = useCookie('Token')
    const requestOptions = {
    method: 'GET',
    headers: {"Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Imp1YW4ifQ.IPj9p160WqUDlcxFg8PGMwpWJ1L6Q7Aqn4N8lwX8StU"},
    }
    const data  = await $fetch(url,requestOptions);
    res.writeHead(200,{"Content-Type": "application/json"});
    res.write(JSON.stringify(data));
    res.end();
};
