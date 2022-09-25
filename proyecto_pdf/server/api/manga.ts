import type { IncomingMessage, ServerResponse } from "http";
import * as url from "url";

export default async(req: IncomingMessage, res: ServerResponse) => {
    //const queryobject = url.parse(req.url as string, true).query;
    //const { search } = queryobject;
    const random = (Math.floor(Math.random() * 5000)).toString()
    const endpoint = 'https://api.jikan.moe/v4/manga/'+ '3' +'/pictures';
    const data = await $fetch(endpoint);
    res.writeHead(200,{"Content-Type": "application/json"});
    res.write(JSON.stringify(data));
    res.end();
};
