#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {HANDLE}

struct NCB {
    ncb_command : UInt8
    ncb_retcode : UInt8
    ncb_lsn : UInt8
    ncb_num : UInt8
    ncb_buffer : UInt8.Ptr
    ncb_length : UInt16
    ncb_callname : UInt8[16]
    ncb_name : UInt8[16]
    ncb_rto : UInt8
    ncb_sto : UInt8
    ncb_post : IntPtr
    ncb_lana_num : UInt8
    ncb_cmd_cplt : UInt8
    ncb_reserve : UInt8[18]
    ncb_event : HANDLE
}
struct ADAPTER_STATUS {
    adapter_address : UInt8[6]
    rev_major : UInt8
    reserved0 : UInt8
    adapter_type : UInt8
    rev_minor : UInt8
    duration : UInt16
    frmr_recv : UInt16
    frmr_xmit : UInt16
    iframe_recv_err : UInt16
    xmit_aborts : UInt16
    xmit_success : UInt32
    recv_success : UInt32
    iframe_xmit_err : UInt16
    recv_buff_unavail : UInt16
    t1_timeouts : UInt16
    ti_timeouts : UInt16
    reserved1 : UInt32
    free_ncbs : UInt16
    max_cfg_ncbs : UInt16
    max_ncbs : UInt16
    xmit_buf_unavail : UInt16
    max_dgram_size : UInt16
    pending_sess : UInt16
    max_cfg_sess : UInt16
    max_sess : UInt16
    max_sess_pkt_size : UInt16
    name_count : UInt16
}
struct NAME_BUFFER {
    name : UInt8[16]
    name_num : UInt8
    name_flags : UInt8
}
struct SESSION_HEADER {
    sess_name : UInt8
    num_sess : UInt8
    rcv_dg_outstanding : UInt8
    rcv_any_outstanding : UInt8
}
struct SESSION_BUFFER {
    lsn : UInt8
    state : UInt8
    local_name : UInt8[16]
    remote_name : UInt8[16]
    rcvs_outstanding : UInt8
    sends_outstanding : UInt8
}
struct LANA_ENUM {
    length : UInt8
    lana : UInt8[255]
}
struct FIND_NAME_HEADER {
    node_count : UInt16
    reserved : UInt8
    unique_group : UInt8
}
struct FIND_NAME_BUFFER {
    length : UInt8
    access_control : UInt8
    frame_control : UInt8
    destination_addr : UInt8[6]
    source_addr : UInt8[6]
    routing_info : UInt8[18]
}
struct ACTION_HEADER {
    transport_id : UInt32
    action_code : UInt16
    reserved : UInt16
}
