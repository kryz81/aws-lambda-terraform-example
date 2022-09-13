data "archive_file" "common-libs" {
  source_dir  = "${path.root}/../app"
  output_path = "${path.root}/../out/layer.zip"
  type        = "zip"
}

resource "aws_lambda_layer_version" "common-libs-layer" {
  layer_name          = "common-libs-layer"
  filename            = "${path.root}/../out/layer.zip"
  compatible_runtimes = [local.runtime]
  depends_on          = [data.archive_file.common-libs]
}
