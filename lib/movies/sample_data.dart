import 'movie.dart';

final sampleMovies = [
  Movie(
    id: 'the-social-reckoning',
    title: 'The Social Reckoning',
    posterUrl:
        'https://www.impawards.com/2026/posters/social_reckoning_ver3.jpg',
    backdropUrl: 'https://media2.firstshowing.net/firstshowing/img18/thesocialrecktrailer2mainimg59.jpg',
    tagline: 'We’re way past making friends.',
    overview: 'Lấy cảm hứng từ câu chuyện có thật về Frances Haugen, một kỹ sư trẻ tại Facebook đã hợp tác cùng nhà báo Jeff Horwitz để phơi bày những bí mật được bảo vệ chặt chẽ nhất của mạng xã hội.',
    genres: ['Drama', 'Thriller', 'Biography'],
    studio: 'Sony Pictures',
    releaseDate: DateTime(2026, 10, 9),
    rating: 0,
    trailers: [
      Trailer(title: 'Official Trailer', duration: '2:36', type: 'Trailer'),
      Trailer(title: 'Inside the Story', duration: '1:48', type: 'Featurette'),
    ],
  ),
  Movie(
    id: 'misty-green',
    title: 'Misty Green',
    posterUrl:
        'https://www.filmvandaag.nl/api/og-image/movie/153588-misty-green.jpg',
    backdropUrl:
        'https://www.filmvandaag.nl/api/og-image/movie/153588-misty-green.jpg',
    tagline: 'Every comeback starts with one brave choice.',
    overview: 'Nhiều năm sau bước đột phá ở Hollywood, một diễn viên tài năng có sự nghiệp đình trệ quyết tâm giành lại cơ hội thứ hai trong ngành công nghiệp khắc nghiệt.',
    genres: ['Drama', 'Comedy'],
    studio: 'A24',
    releaseDate: DateTime(2026, 10, 9),
    rating: 0,
    trailers: [
      Trailer(title: 'Official Trailer', duration: '2:18', type: 'Trailer'),
      Trailer(
        title: 'A Note from Chris Rock',
        duration: '1:35',
        type: 'Featurette',
      ),
    ],
  ),
  Movie(
    id: 'forgotten-island',
    title: 'Forgotten Island',
    posterUrl:
        'https://www.impawards.com/2026/posters/forgotten_island_ver2.jpg',
    backdropUrl: 'https://od2-image-api.abs-cbn.com/prod/editorImage/1774511883831%5Bimage%5D%20-%206492786.jpeg',
    tagline: 'Go together.',
    overview: 'Hai người bạn thân Jo và Raissa bước qua một cánh cổng bí ẩn đến đảo Nakali. Muốn trở về, họ phải đối mặt với những ký ức, sinh vật kỳ ảo và nguy cơ quên mất tình bạn của chính mình.',
    genres: ['Animation', 'Adventure', 'Family'],
    studio: 'DreamWorks Animation',
    releaseDate: DateTime(2026, 9, 25),
    rating: 0,
    trailers: [
      Trailer(title: 'Official New Trailer', duration: '2:24', type: 'Trailer'),
      Trailer(title: 'Welcome to Nakali', duration: '1:42', type: 'Featurette'),
    ],
  ),
  Movie(
    id: 'resident-evil-2026',
    title: 'Resident Evil',
    posterUrl:
        'https://pics.filmaffinity.com/Resident_Evil-690895470-large.jpg',
    backdropUrl: 'https://img.3dmgame.com/uploads/images/news/20260522/1779415822_734573.jpg',
    tagline: 'Survive the night.',
    overview: 'Bryan, một nhân viên chuyển phát y tế, vô tình bị cuốn vào cuộc đua sinh tồn không ngừng nghỉ khi một đêm kinh hoàng sụp đổ thành hỗn loạn.',
    genres: ['Horror', 'Action', 'Science Fiction'],
    studio: 'Sony Pictures · Constantin Film',
    releaseDate: DateTime(2026, 9, 18),
    rating: 7.3,
    trailers: [
      Trailer(title: 'Official Trailer', duration: '2:29', type: 'Trailer'),
      Trailer(
        title: 'Surviving the Night',
        duration: '1:51',
        type: 'Behind the scenes',
      ),
    ],
  ),
];
