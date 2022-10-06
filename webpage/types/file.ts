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

export interface Images {
    jpg: Jpg;
    webp: Webp;
};

export default interface Manga {
    images: Images;
    title: string;
    mal_id: number;
}