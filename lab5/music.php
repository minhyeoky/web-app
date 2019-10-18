<!DOCTYPE html>
<html lang="en">

	<head>
		<title>Music Library</title>
		<meta charset="utf-8" />
		<link href="https://selab.hanyang.ac.kr/courses/cse326/2019/labs/images/5/music.jpg" type="image/jpeg" rel="shortcut icon" />
		<link href="https://selab.hanyang.ac.kr/courses/cse326/2019/labs/labResources/music.css" type="text/css" rel="stylesheet" />
	</head>

	<body>
		<h1>My Music Page</h1>
		
		<!-- Ex 1: Number of Songs (Variables) -->
		<p>
			<?php
			$song_count = 5678;
			$song_hour = (int)($song_count / 10);
			echo "I love music.";
			echo "I have $song_count total songs,";
			echo "which is over $song_hour hours of music!";
			?>
		</p>

		<!-- Ex 2: Top Music News (Loops) -->
		<!-- Ex 3: Query Variable -->
		<div class="section">
			<h2>Billboard News</h2>
		
			<ol>
				<?php
				$newspages = 6; // 11 - 5;
				if (isset($_GET["newspages"])) {
					$newspages = 11 - (int) $_GET["newspages"];
					// validate value
					if ($newspages < 0) {
						$newspages = 0;
					}
				}
				for ($news_pages = 11; $news_pages > $newspages; $news_pages--) { ?>
					<li><a href="https://www.billboard.com/archive/article/2019<?=$news_pages?>">2019-<?=$news_pages?></a></li>
				<?php } ?>
			</ol>
		</div>

		<!-- Ex 4: Favorite Artists (Arrays) -->
		<!-- Ex 5: Favorite Artists from a File (Files) -->
		<div class="section">
			<h2>My Favorite Artists</h2>
		
			<ol>
				<?php
				$favorite = file("./favorite.txt");
				// $artists = array("Guns N' Roses", "Green Day", "Blink182", "Queen");
				foreach ($favorite as $artist) { ?>
					<li><?= $artist ?></li>
				<?php } ?>
<!-- 				
				<li>Guns N' Roses</li>
				<li>Green Day</li>
				<li>Blink182</li> -->
			</ol>
		</div>
		
		<!-- Ex 6: Music (Multiple Files) -->
		<!-- Ex 7: MP3 Formatting -->
		<div class="section">
			<h2>My Music and Playlists</h2>

			<ul id="musiclist">
				<?php
				function _sort_fn($a, $b) {
					$size_a = filesize($a);
					$size_b = filesize($b);

					return ($size_a < $size_b) ? 1 : -1;
				}
				$songs = glob("songs/*.mp3");
				$_ = usort($songs, "_sort_fn");
				foreach ($songs as $mp3) { ?>
					<li class="mp3item">
						<a href=<?= $mp3 ?>><?= basename($mp3) ?> (<?=(int) (filesize($mp3) / 1024)?> KB)</a>
					</li>
				<?php } ?>
				<!-- <li class="mp3item">
					<a href="lab5/musicPHP/songs/paradise-city.mp3">paradise-city.mp3</a>
				</li>
				
				<li class="mp3item">
					<a href="lab5/musicPHP/songs/basket-case.mp3">basket-case.mp3</a>
				</li>

				<li class="mp3item">
					<a href="lab5/musicPHP/songs/all-the-small-things.mp3">all-the-small-things.mp3</a>
				</li> -->

				<!-- Exercise 8: Playlists (Files) -->
				<?php
				$m3u_array = glob("songs/*.m3u");
				$_ = rsort($m3u_array);
				foreach ($m3u_array as $m3u) { ?>
					<li class="playlistitem"> <?= basename($m3u) ?>:
					
					<?php 
					$items = file($m3u, FILE_TEXT);
					$_ = shuffle($items);
					foreach ($items as $item) { ?>
						<ul>
							<?php 
							$pos = stripos($item, "#");
							if ($pos !== 0) { ?>
								<li><?= $item ?> <?= stripos($item, "#") ?></li>
							<?php } ?>
						</ul>
						
					<?php } ?>
					
				<?php } ?> 
				<!-- <li class="playlistitem">326-13f-mix.m3u:
					<ul>
						<li>Basket Case.mp3</li>
						<li>All the Small Things.mp3</li>
						<li>Just the Way You Are.mp3</li>
						<li>Pradise City.mp3</li>
						<li>Dreams.mp3</li>
					</ul> -->
			</ul>
		</div>

		<div>
			<a href="https://validator.w3.org/check/referer">
				<img src="https://selab.hanyang.ac.kr/courses/cse326/2019/labs/images/w3c-html.png" alt="Valid HTML5" />
			</a>
			<a href="https://jigsaw.w3.org/css-validator/check/referer">
				<img src="https://selab.hanyang.ac.kr/courses/cse326/2019/labs/images/w3c-css.png" alt="Valid CSS" />
			</a>
		</div>
	</body>
</html>
