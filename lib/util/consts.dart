const String key = 'api_key=8d61230b01928fe55a53a48a41dc839b';
const String imageBaseURL = 'https://image.tmdb.org/t/p/w500';
const String posterImageBaseURL = 'https://image.tmdb.org/t/p/original';
const String baseURL = 'https://api.themoviedb.org/3/movie';
const String config = '&language=en-US';

const String mostPopular = '$baseURL/popular?$key$config';
const String topRated = '$baseURL/top_rated?$key$config';
