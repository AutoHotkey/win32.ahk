#import "InterfacePointer.ahk" {InterfacePointer}
#import "GUID.ahk" {GUID}

struct IUnknown extends InterfacePointer {
    static IID := "{00000000-0000-0000-C000-000000000046}"
    as(interface) {
        r := ComCall(0, this.p, GUID.Ptr, interface.IID, interface.Ptr, &ppvObject, Int32)
        if r >= 0
            return ppvObject
        if r = -2147467263 ; E_NOTIMPL
            return unset
        throw OSError(r)
    }
    __new(p := 0) {
        if p is ComValue && (ComObjType(p) = 13 || ComObjType(p) = 9)
            ObjAddRef(this.p := ComObjValue(p))
        else
            this.p := p
    }
    __delete() {
        (this.p) && ObjRelease(this.p)
    }
    QueryInterface(riid, ppvObject)
      => ComCall(0, this.p, GUID.Ptr, riid, IntPtr.Ptr, ppvObject)
}
