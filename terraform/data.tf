data "aws_subnet_ids" "subnet" {
    vpc_id = aws_vpc.pdfvpc.id
}
