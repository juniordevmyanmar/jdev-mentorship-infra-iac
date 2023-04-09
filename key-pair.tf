resource "aws_key_pair" "jr-dev-mm" {
  key_name   = "jr-dev-mm"
  public_key = file("jr-dev-mm.pub")
}