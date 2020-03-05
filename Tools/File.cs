using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

namespace Camarco.Tools
{
	public static class FileManager
	{
		public static byte[] ConvertStreamToByteBuffer(System.IO.Stream theStream)
		{
			int b1;
			System.IO.MemoryStream tempStream = new System.IO.MemoryStream();
			while ((b1 = theStream.ReadByte()) != -1)
			{
				tempStream.WriteByte(((byte)b1));
			}
			byte[] retval = tempStream.ToArray();
			tempStream.Close();
			return retval;
		}
		public static string ReadBinaryFile(string path, string fileName)
		{

			string full = path + fileName;
			if (File.Exists(@full))
			{
				using (FileStream fileStream = File.OpenRead(@full))
				{
					try
					{
						return Convert.ToBase64String(ConvertStreamToByteBuffer(fileStream));
					}
					catch
					{
						return "";
					}
					finally
					{
						fileStream.Close();
					}
				}
			}
			else
			{
				return "";
			}
		}
		public static System.Text.StringBuilder GetFileText(string FilePath)
		{
			try
			{
				using (System.IO.StreamReader streamMail = new System.IO.StreamReader(FilePath, System.Text.Encoding.UTF8))
				{
					System.Text.StringBuilder strBMail = new System.Text.StringBuilder(streamMail.ReadToEnd());
					streamMail.Close();
					streamMail.Dispose();
					return strBMail;
				}
			}
			catch 
			{
				return null;
			}
		}
		public static int GetKBytes(string path, string fileName)
		{
			try
			{
				string full = path + fileName;
				if (File.Exists(@full))
				{
					FileInfo fi = new FileInfo(@full);
					try
					{
						return (int)fi.Length / 1024;
					}
					catch
					{
						return 0;
					}

				}
				return 0;
			}
			catch 
			{

				return 0;
			}
		}
		public static void ResizeImage(int x, int y, int selectedWidth, int selectedHeight,int newWidth, int newHeight, string filePath, string saveFilePath)
		{
			
			//create new image object
			Bitmap curImage = new Bitmap(filePath);

			//Create new object image
			Bitmap newImage = new Bitmap((int)newWidth, (int)newHeight);
			Graphics imgDest = Graphics.FromImage(newImage);
			imgDest.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
			imgDest.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
			imgDest.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
			imgDest.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
			ImageCodecInfo[] info = ImageCodecInfo.GetImageEncoders();
			EncoderParameters param = new EncoderParameters(1);
			param.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);

			//Draw the object image
			imgDest.DrawImage(curImage, new System.Drawing.Rectangle(0,0,newWidth,newHeight),x, y, selectedWidth, selectedHeight,System.Drawing.GraphicsUnit.Pixel);

			//Save image file
			newImage.Save(saveFilePath, info[1], param);

			//Dispose the image objects
			curImage.Dispose();
			newImage.Dispose();
			imgDest.Dispose();
		}
		
		public static void CropImage(int newWidth, int newHeight, string filePath, string saveFilePath)
		{

			//create new image object
			Bitmap curImage = new Bitmap(filePath);

			//Create new object image
			Bitmap newImage = new Bitmap((int)newWidth, (int)newHeight);
			Graphics imgDest = Graphics.FromImage(newImage);
			imgDest.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
			imgDest.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
			imgDest.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
			imgDest.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
			ImageCodecInfo[] info = ImageCodecInfo.GetImageEncoders();
			EncoderParameters param = new EncoderParameters(1);
			param.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
			if (Math.Round(((double)curImage.Width / (double)curImage.Height), 1) == Math.Round(((double)newWidth / (double)newHeight), 1))
			{
				imgDest.DrawImage(curImage, new Rectangle(0, 0, newWidth, newHeight));
			}
			else
			{
				if (((double)newWidth * (double)curImage.Height / (double)curImage.Width) >= newHeight)
				{
					imgDest.DrawImage(curImage, new Rectangle(0, 0, newWidth, (int)Math.Round((decimal)newWidth*curImage.Height/curImage.Width,0)));
				}
				else
				{
					imgDest.DrawImage(curImage, new Rectangle(0, 0, (int)Math.Round((decimal)newHeight * curImage.Width / curImage.Height, 0), newHeight));
				}
				
			}
			
			//Save image file
			newImage.Save(saveFilePath, info[1], param);

			//Dispose the image objects
			curImage.Dispose();
			newImage.Dispose();
			imgDest.Dispose();
		}

        public static void CropImageMantain(int newWidth, int newHeight, string filePath, string saveFilePath)
        {
            //create new image object
            Bitmap curImage = new Bitmap(filePath);
            int targetWidth = 0, targetHeight = 0;
            if (curImage.Width > newWidth)
            {
                if (Math.Round(((double)curImage.Width / (double)curImage.Height), 1) == Math.Round(((double)newWidth / (double)newHeight), 1))
                {
                    targetWidth = newWidth;
                    targetHeight = newHeight;

                }
                else
                {
                    targetWidth = newWidth;
                    targetHeight = (int)Math.Round((decimal)newWidth * curImage.Height / curImage.Width, 0);
                }

            }
            else
            {
                //mantener la imagen
                targetWidth = curImage.Width;
                targetHeight = curImage.Height;
            }



            //Create new object image
            Bitmap newImage = new Bitmap(targetWidth, targetHeight);
            Graphics imgDest = Graphics.FromImage(newImage);
            imgDest.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            imgDest.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            imgDest.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
            imgDest.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
            ImageCodecInfo[] info = ImageCodecInfo.GetImageEncoders();
            EncoderParameters param = new EncoderParameters(1);
            param.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
            imgDest.DrawImage(curImage, new Rectangle(0, 0, targetWidth, targetHeight));

            //Save image file
            newImage.Save(saveFilePath, info[1], param);
            //Dispose the image objects
            curImage.Dispose();
            newImage.Dispose();
            imgDest.Dispose();
        }

        public static void CropImageMantainForThumb(int newWidth, int newHeight, string filePath, string saveFilePath)
        {
            //create new image object
            Bitmap curImage = new Bitmap(filePath);
            int targetWidth = 0, targetHeight = 0;
            if (curImage.Width > newWidth)
            {
                if (Math.Round(((double)curImage.Width / (double)curImage.Height), 1) == Math.Round(((double)newWidth / (double)newHeight), 1))
                {
                    targetWidth = newWidth;
                    targetHeight = newHeight;

                }
                else
                {
                    targetWidth = newWidth;
                    targetHeight = (int)Math.Round((decimal)newWidth * curImage.Height / curImage.Width, 0);
                }

            }
            else
            {
                //mantener la imagen
                targetWidth = curImage.Width;
                targetHeight = curImage.Height;
            }
            


            //Create new object image
            Bitmap newImage = new Bitmap(targetWidth, targetHeight);
            Graphics imgDest = Graphics.FromImage(newImage);
            imgDest.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            imgDest.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            imgDest.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
            imgDest.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
            ImageCodecInfo[] info = ImageCodecInfo.GetImageEncoders();
            EncoderParameters param = new EncoderParameters(1);
            param.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
            imgDest.DrawImage(curImage, new Rectangle(0, 0, targetWidth, targetHeight));
            //regla de recorte para Thumbs para imagenes mas altas que anchas
            //Save image file
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
            //Dispose the image objects
            curImage.Dispose();
            newImage.Dispose();
            imgDest.Dispose();
        }
	}

}
