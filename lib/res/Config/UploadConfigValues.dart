class UploadConfig {
// storage providers and upload endpoints
  static String ipfsVideoUrl = "https://ipfs.d.tube/ipfs/";
  static String siaVideoUrl = "https://siasky.net/";
  static String ipfsUploadUrl = "https://ipfs.d.tube/ipfs/";

  static List<String> btfsUploadEndpoints = [
    "https://upload.dtube.fso.ovh:5003"
  ];

  static List<Map<String, String>> web3StorageEndpoints = [{"api": "https://upload.dtube.fso.ovh:5082",
  "tus": "http://upload.dtube.fso.ovh:1080"}];
  static String web3StorageGateway = "https://ipfs.io";
  static int maxUploadRetries = 2;

  static String ipfsSnapUrl = 'https://ipfs.io/ipfs/';
  static String ipfsSnapUploadUrl = 'https://snap1.d.tube';
}
