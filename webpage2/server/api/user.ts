import type { IncomingMessage, ServerResponse } from "http";

export default async(req: IncomingMessage, res: ServerResponse) => {
    const url = "http://127.0.0.1:5000/users"
    const data  = await $fetch(url,{headers : {"Authorization":req.headers.authorization}});
    res.writeHead(200,{"Content-Type": "application/json"});
    res.write(JSON.stringify(data));
    res.end();
};
