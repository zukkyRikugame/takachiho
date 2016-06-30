package imgrecognition;

import java.nio.file.Path;

import org.opencv.core.Mat;
import org.opencv.core.MatOfKeyPoint;
import org.opencv.features2d.DescriptorExtractor;
import org.opencv.features2d.FeatureDetector;
//import org.opencv.highgui.Highgui;
import org.opencv.imgproc.Imgproc;

//OpenCV3
import org.opencv.imgcodecs.Imgcodecs;

public class FeatureExtractor {
	private final FeatureDetector featureDetector;
	private final DescriptorExtractor descriptorExtractor;

	public FeatureExtractor() {
//		String configPath = getClass().getResource("sift_config").getPath(); //configは後で検討
		featureDetector = FeatureDetector.create(FeatureDetector.ORB);
//		featureDetector.read(configPath); //configは後で検討
		descriptorExtractor = DescriptorExtractor.create(DescriptorExtractor.ORB);
//		descriptorExtractor.read(configPath);//configは後で検討
	}

	public Mat extract(Path imagePath) {
		// 画像データの読み込み
		Mat image = Imgcodecs.imread(imagePath.toString());

		// 白黒画像データの作成
		Mat grayImage = new Mat();
		Imgproc.cvtColor(image, grayImage, Imgproc.COLOR_BGRA2GRAY);

		// キーポイント検出
		MatOfKeyPoint keyPoints = new MatOfKeyPoint();
		featureDetector.detect(grayImage, keyPoints);

		// 特徴量記述
		Mat descriptors = new Mat();
		descriptorExtractor.compute(grayImage, keyPoints, descriptors);
		return descriptors;
	}
}
