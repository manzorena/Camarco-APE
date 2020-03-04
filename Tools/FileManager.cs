using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Text;

namespace Camarco.Tools
{
	public static class FileManager
	{
		public static byte[] ConvertStreamToByteBuffer(Stream theStream)
		{
			MemoryStream tempStream = new MemoryStream();
			int b;
			while ((b = theStream.ReadByte()) != -1)
			{
				tempStream.WriteByte((byte)b);
			}
			byte[] retval = tempStream.ToArray();
			tempStream.Close();
			return retval;
		}

		public static string ReadBinaryFile(string path, string fileName)
		{
			string full = path + fileName;
			string result;
			if (File.Exists(full))
			{
				using (FileStream fileStream = File.OpenRead(full))
				{
					try
					{
						result = Convert.ToBase64String(FileManager.ConvertStreamToByteBuffer(fileStream));
						return result;
					}
					catch
					{
						result = "";
						return result;
					}
					finally
					{
						fileStream.Close();
					}
				}
			}
			result = "";
			return result;
		}

		public static StringBuilder GetFileText(string FilePath)
		{
			StringBuilder result;
			try
			{
				using (StreamReader streamMail = new StreamReader(FilePath, Encoding.UTF8))
				{
					StringBuilder strBMail = new StringBuilder(streamMail.ReadToEnd());
					streamMail.Close();
					streamMail.Dispose();
					result = strBMail;
				}
			}
			catch
			{
				result = null;
			}
			return result;
		}

		public static int GetKBytes(string path, string fileName)
		{
			int result;
			try
			{
				string full = path + fileName;
				if (File.Exists(full))
				{
					FileInfo fi = new FileInfo(full);
					try
					{
						result = (int)fi.Length / 1024;
						return result;
					}
					catch
					{
						result = 0;
						return result;
					}
				}
				result = 0;
			}
			catch
			{
				result = 0;
			}
			return result;
		}

		public static void ResizeImage(int x, int y, int selectedWidth, int selectedHeight, int newWidth, int newHeight, string filePath, string saveFilePath)
		{
			Bitmap curImage = new Bitmap(filePath);
			Bitmap newImage = new Bitmap(newWidth, newHeight);
			Graphics imgDest = Graphics.FromImage(newImage);
			imgDest.SmoothingMode = SmoothingMode.HighQuality;
			imgDest.InterpolationMode = InterpolationMode.HighQualityBicubic;
			imgDest.PixelOffsetMode = PixelOffsetMode.HighQuality;
			imgDest.CompositingQuality = CompositingQuality.HighQuality;
			ImageCodecInfo[] info = ImageCodecInfo.GetImageEncoders();
			EncoderParameters param = new EncoderParameters(1);
			param.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
			imgDest.DrawImage(curImage, new Rectangle(0, 0, newWidth, newHeight), x, y, selectedWidth, selectedHeight, GraphicsUnit.Pixel);
			newImage.Save(saveFilePath, info[1], param);
			curImage.Dispose();
			newImage.Dispose();
			imgDest.Dispose();
		}

		public static void CropImage(int newWidth, int newHeight, string filePath, string saveFilePath)
		{
			Bitmap curImage = new Bitmap(filePath);
			Bitmap newImage = new Bitmap(newWidth, newHeight);
			Graphics imgDest = Graphics.FromImage(newImage);
			imgDest.SmoothingMode = SmoothingMode.HighQuality;
			imgDest.InterpolationMode = InterpolationMode.HighQualityBicubic;
			imgDest.PixelOffsetMode = PixelOffsetMode.HighQuality;
			imgDest.CompositingQuality = CompositingQuality.HighQuality;
			ImageCodecInfo[] info = ImageCodecInfo.GetImageEncoders();
			EncoderParameters param = new EncoderParameters(1);
			param.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
			if (Math.Round((double)curImage.Width / (double)curImage.Height, 1) == Math.Round((double)newWidth / (double)newHeight, 1))
			{
				imgDest.DrawImage(curImage, new Rectangle(0, 0, newWidth, newHeight));
			}
			else if ((double)newWidth * (double)curImage.Height / (double)curImage.Width >= (double)newHeight)
			{
				imgDest.DrawImage(curImage, new Rectangle(0, 0, newWidth, (int)Math.Round(newWidth * curImage.Height / curImage.Width, 0)));
			}
			else
			{
				imgDest.DrawImage(curImage, new Rectangle(0, 0, (int)Math.Round(newHeight * curImage.Width / curImage.Height, 0), newHeight));
			}
			newImage.Save(saveFilePath, info[1], param);
			curImage.Dispose();
			newImage.Dispose();
			imgDest.Dispose();
		}

		public static void CropImageMantain(int newWidth, int newHeight, string filePath, string saveFilePath)
		{
			Bitmap curImage = new Bitmap(filePath);
			int targetWidth;
			int targetHeight;
			if (curImage.Width > newWidth)
			{
				if (Math.Round((double)curImage.Width / (double)curImage.Height, 1) == Math.Round((double)newWidth / (double)newHeight, 1))
				{
					targetWidth = newWidth;
					targetHeight = newHeight;
				}
				else
				{
					targetWidth = newWidth;
					targetHeight = (int)Math.Round(newWidth * curImage.Height / curImage.Width, 0);
				}
			}
			else
			{
				targetWidth = curImage.Width;
				targetHeight = curImage.Height;
			}
			Bitmap newImage = new Bitmap(targetWidth, targetHeight);
			Graphics imgDest = Graphics.FromImage(newImage);
			imgDest.SmoothingMode = SmoothingMode.HighQuality;
			imgDest.InterpolationMode = InterpolationMode.HighQualityBicubic;
			imgDest.PixelOffsetMode = PixelOffsetMode.HighQuality;
			imgDest.CompositingQuality = CompositingQuality.HighQuality;
			ImageCodecInfo[] info = ImageCodecInfo.GetImageEncoders();
			EncoderParameters param = new EncoderParameters(1);
			param.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
			imgDest.DrawImage(curImage, new Rectangle(0, 0, targetWidth, targetHeight));
			newImage.Save(saveFilePath, info[1], param);
			curImage.Dispose();
			newImage.Dispose();
			imgDest.Dispose();
		}

		public static void CropImageMantainForThumb(int newWidth, int newHeight, string filePath, string saveFilePath)
		{
			Bitmap curImage = new Bitmap(filePath);
			int targetWidth;
			int targetHeight;
			if (curImage.Width > newWidth)
			{
				if (Math.Round((double)curImage.Width / (double)curImage.Height, 1) == Math.Round((double)newWidth / (double)newHeight, 1))
				{
					targetWidth = newWidth;
					targetHeight = newHeight;
				}
				else
				{
					targetWidth = newWidth;
					targetHeight = (int)Math.Round(newWidth * curImage.Height / curImage.Width, 0);
				}
			}
			else
			{
				targetWidth = curImage.Width;
				targetHeight = curImage.Height;
			}
			Bitmap newImage = new Bitmap(targetWidth, targetHeight);
			Graphics imgDest = Graphics.FromImage(newImage);
			imgDest.SmoothingMode = SmoothingMode.HighQuality;
			imgDest.InterpolationMode = InterpolationMode.HighQualityBicubic;
			imgDest.PixelOffsetMode = PixelOffsetMode.HighQuality;
			imgDest.CompositingQuality = CompositingQuality.HighQuality;
			ImageCodecInfo[] info = ImageCodecInfo.GetImageEncoders();
			EncoderParameters param = new EncoderParameters(1);
			param.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
			imgDest.DrawImage(curImage, new Rectangle(0, 0, targetWidth, targetHeight));
			newImage.Save(saveFilePath, info[1], param);
			if (targetHeight > targetWidth && targetHeight > 142)
			{
				Bitmap newImage2 = new Bitmap(targetWidth, 142);
				Graphics imgDest2 = Graphics.FromImage(newImage2);
				int y = -(targetHeight - 142) / 2;
				imgDest2.DrawImage(newImage, new Rectangle(0, y, targetWidth, targetHeight));
				newImage2.Save(saveFilePath, info[1], param);
				newImage2.Dispose();
				imgDest2.Dispose();
			}
			curImage.Dispose();
			newImage.Dispose();
			imgDest.Dispose();
		}
	}
}
