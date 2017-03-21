/*********************************
 FuZhou University, SDNLab
 Added by Chen, 2017.3.21
 *********************************/

// parser.p4

parser start {
    return parse_ethernet;
}

header ethernet_t ethernet;
metadata intrinsic_metadata_t intrinsic_metadata;
metadata port_sec_metadata_t port_sec_metadata;

parser parse_ethernet {
    extract(ethernet);
    return ingress;
}
