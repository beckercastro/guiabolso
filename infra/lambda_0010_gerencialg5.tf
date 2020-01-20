# LAMBDA
resource "aws_lambda_function" "lambda_gerencialg5" {
  s3_bucket     = var.bucket_name
  s3_key        = var.zip_file
  function_name = "CB_Pagar_0010_gerencialG5_dev"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs12.x"
  timeout       = 60
  memory_size   = 256

  environment {
    variables = {
      PATH_CSV_FILE             = "pismo_statuscontas.csv"
      BUCKET_LEITURA_PROD       = "itau-data-dev-cartaobranco-raw"
      BUCKET_ESCRITA_PROD       = "cb-fluxob-nfs-dev"
      PATH_SUB_FOLDER           = "pismo/portfolio/"
      VOL_H_TPREG               = "1"
      VOL_H_SIST_ORIGEM         = "ES7"
      VOL_D_TPREG               = "2"
      EVENTO_CONTA_ATIVA        = "600"
      EVENTO_CONTA_NOVA         = "601"
      VOL_D_QUANTIDADE          = "00000000000000001"
      VOL_T_TPREG               = "3"
      TIPPES                    = "F"
      STAT_ATIVAS               = "0"
      STAT_CANCELADAS           = "1"
      ADMINI                    = "004"
      NMCLI                     = "0000000000000000000000000000000000000000"
      TIPOPLAT                  = "00"
      CODRET                    = "0A"
      DICOMPLAT                 = "00"
      REGIAOPLAT                = "00"
      AGEPLAT                   = "0000"
      CODPO_CARTAO_BRANCO       = "840140010101"
      CODPO_MERCADO_LIVRE       = "840150010401"
      CODPO_CREDCARD_ZERO_GOLD  = "840160010405"
      MODULOGQ                  = "00"
      CANAL                     = "00"
      SEGMGER                   = "00"
      GERENTE                   = "00"
      AGENCIA                   = "00000"
      CONTA                     = "000000000000000"
      MNEMOG1_CARTAO_BRANCO     = "CartaoBranco"
      MNEMOG1_MERCADO_LIVRE     = "CartaoMercadoLivre"
      MNEMOG1_CREDICAR_BETA     = "CredicardBeta"
      PROGRAMA_CB               = "Cartao Branco"
      PROGRAMA_CB_DIR           = "Cartao Branco - Diretores"
      PROGRAMA_ML               = "Mercado Livre"
      PROGRAMA_CREDCARD         = "Credicard Zero Gold"
      CPRODLIM_CARTAO_BRANCO    = "48568"
      CPRODLIM_MERCADO_LIVRE    = "48571"
      CPRODLIM_CREDICAR_BETA    = "98231"
      QTADIC                    = "00000"
      CODBANCO                  = "341"
      ALCDAGCTE                 = "000000"
      ALORIGCLI                 = "000"
      ALORGCV                   = "00000"
      ALCANVEN                  = "000"
      ALCANDIS                  = "000"
      ALCANCOM                  = "000"
      ALSUBCAN                  = "000"
      EMPCTB                    = "070"
      BCOCTB                    = "426"
      EMPRES                    = "426"
      BCORES                    = "426"
      EMPCLI                    = "426"
      EMPORIG                   = "000"
      BCOORIG                   = "000"
      DTADMI                    = "000000"
      CODSIS                    = "84"
      DEPTOCTB                  = "00002"
      TPREG                     = "0"
      TPREGD                    = "1"
      TPREGT                    = "9"
      CODSIST                   = "ES"
      PATH_S3_CADASTRAL         = "Relatorio/GerencialG5/Cadastral/"
      PATH_S3_VOLUMETRIA        = "Relatorio/GerencialG5/Volumetria/"
      PATH_VOLUMETRIA_FILE      = "G5-Volumetria-"
      PATH_CADASTRAL_FILE       = "G5-Cadastral-"
      PATH_ERRO_VOLUMETRIA_FILE = "G5-Volumetria-Erros-"
      PATH_ERRO_CADASTRAL_FILE  = "G5-Cadastral-Erros-"
      LAMBDA_NFS                = "CB_Pagar_0004_Test"
    }
  }
}

# ROLE AND POLICY
resource "aws_iam_role" "lambda_role" {
  name = "lambda_s3_nfs_tf"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name = "lambda_s3_access_tf"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt",
                "s3:ListBucket",
                "s3:ListMultipartUploadParts",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "s3:PutObject",
                "s3:GetObject",
                "s3:AbortMultipartUpload",
                "kms:Encrypt",
                "s3:GetObjectTagging",
                "kms:DescribeKey",
                "s3:PutObjectTagging",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::cb-fluxob-nfs-dev/*",
                "arn:aws:s3:::cb-fluxob-nfs-dev",
                "arn:aws:kms:us-east-1:405635533773:key/cee54671-b86c-4428-9c44-d68d591b18fa"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "lambda:ListFunctions",
                "lambda:InvokeFunction",
                "lambda:ListVersionsByFunction",
                "lambda:GetFunction",
                "lambda:ListAliases",
                "s3:ListBucket",
                "lambda:InvokeAsync",
                "s3:ListMultipartUploadParts",
                "s3:PutObject",
                "s3:GetObject",
                "s3:AbortMultipartUpload",
                "lambda:ListEventSourceMappings",
                "s3:GetObjectTagging",
                "s3:PutObjectTagging",
                "lambda:ListLayerVersions",
                "lambda:ListLayers",
                "s3:DeleteObject",
                "s3:HeadBucket"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.policy.arn
}

# CLOUDWATCH
resource "aws_cloudwatch_event_rule" "first_day" {
  name                = "run_every_first_day"
  description         = "Executa todo dia 1 do mes, as 8h"
  schedule_expression = "cron(0 8 1 * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_gerencialg5_first_day" {
  rule      = aws_cloudwatch_event_rule.first_day.name
  target_id = "lambda_gerencialg5"
  arn       = aws_lambda_function.lambda_gerencialg5.arn
}

resource "aws_lambda_permission" "cloudwatch_exec_lambda_gerencialg5" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_gerencialg5.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.first_day.arn
}
