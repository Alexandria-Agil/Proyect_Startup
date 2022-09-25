export interface Jpg {
    image_url: string;
    large_image_url: string;
    small_image_url: string;
};
export interface Webp {
    image_url: string;
    large_image_url: string;
    small_image_url: string;
};

export default interface Manga {
    jpg: Jpg;
    webp: Webp;
}