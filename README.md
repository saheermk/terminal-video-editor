# terminal-video-editor
Edit Videos Using Terminal

---

# 🎬 Terminal Video Editor

A minimal and efficient set of Bash scripts for cropping the bottom 50 pixels from a batch of videos and optionally merging them into a single output file using FFmpeg.

## 📁 Project Structure

- `batch_crop_50px_bottom.sh` – Crops the bottom 50 pixels from all numerically named `.mp4` files in the directory.
- `crop_and_merge.sh` – Crops the bottom 50 pixels from all numerically named video files (`.mp4`, `.mkv`, `.mov`, `.avi`), converts them to `.mov`, and merges them into a single output file.

---

## ⚙️ Requirements

- [FFmpeg](https://ffmpeg.org/download.html)
- [FFprobe](https://ffmpeg.org/ffprobe.html) (usually comes with FFmpeg)

Install FFmpeg:
```bash
sudo apt install ffmpeg

---

## 🛠 Usage

### 1. Cropping Videos (Only)

To crop only `.mp4` videos:

```bash
chmod +x batch_crop_50px_bottom.sh
./batch_crop_50px_bottom.sh
```

* Input: `1.mp4`, `2.mp4`, `3.mp4`, etc.
* Output: Cropped videos saved in `cropped/` folder.

### 2. Cropping and Merging

To crop and automatically merge the videos:

```bash
chmod +x crop_and_merge.sh
./crop_and_merge.sh
```

* Input: Files like `1.mp4`, `2.mkv`, etc.
* Output:

  * Temporary `.mov` cropped versions
  * Final merged file: `cropped/final_output.mov`
  * Temporary files are deleted after merging.

---

## 📝 Notes

* Files must be named as numbers, e.g., `1.mp4`, `2.mkv`, etc., for sorting.
* Make sure your terminal is in the same directory as the scripts and video files before running.
* Cropping is lossless or high-quality (`libx264 -crf 0` for `.mp4`, `prores_ks` for `.mov`).

---

## 📂 Directory Example

```
.
├── 1.mp4
├── 2.mp4
├── batch_crop_50px_bottom.sh
├── crop_and_merge.sh
└── cropped/
    ├── 1.mp4 (cropped)
    ├── 2.mp4 (cropped)
    └── final_output.mov (if using merge script)
```

---

## 📖 License

MIT License © 2025 [Saheer MK](https://github.com/saheermk)

