package crud.getData;

import java.io.InputStream;

public class ImagenVO {

    /*Todo los atributos*/
    int idEmpresa, idAvance, idTarea, idTrabajo, idProcedimiento, idPaso;

    String nombreFile, detalle, typeFile, idArchivo;
    String contentType;
    InputStream archivoData;
    private byte[] archiveByte;

    // public ImagenVO(int id, String name, byte[] archivo) {
    //     this.idEmpresa = id;
    //     this.nombreFile = name;
    //     this.archiveByte = archivo;        
    // }

    public ImagenVO() {}

    /*Todo los codigos get*/
    public String getIdArchivo() {
        return idArchivo;
    }

    public int getIdEmpresa() {
        return idEmpresa;
    }
    public int getidAvance() {
        return idAvance;
    }
    public int getidTarea() {
        return idTarea;
    }
    public int getidTrabajo() {
        return idTrabajo;
    }
    public int getidProcedimiento() {
        return idProcedimiento;
    }
    public int getidPaso() {
        return idPaso;
    }

    public String getContentType() {
        return contentType;
    }

    public String getNombreFile() {
        return nombreFile;
    }

    public InputStream getArchivo() {
        return archivoData;
    }

    public String getDetalle(){
        return detalle;
    }

    public String getTypeFile(){
        return typeFile;
    }


    /*Todo los codigos set*/
    public void setIdEmpresa(int codigoID) {
        this.idEmpresa = codigoID;
    }

    public void setIdArchivo(String codigoID) {
        this.idArchivo = codigoID;
    }

    public void setidAvance(int codigoID) {
        this.idAvance = codigoID;
    }
    public void setidTarea(int codigoID) {
        this.idTarea = codigoID;
    }
    public void setidTrabajo(int codigoID) {
        this.idTrabajo = codigoID;
    }
    public void setidProcedimiento(int codigoID) {
        this.idProcedimiento = codigoID;
    }
    public void setidPaso(int codigoID) {
        this.idPaso = codigoID;
    }

    public void setContentType(String type) {
        this.contentType = type;
    }

    public void setNombreFile(String nombreFile) {
        this.nombreFile = nombreFile;
    }

    public void setArchivo(InputStream archivoData) {
        this.archivoData = archivoData;
    }

    public void setDetalle(String detalle){
        this.detalle = detalle;
    }

    public void setTypeFile(String typeFile){
        this.typeFile = typeFile;
    }


    public byte[] getArchiveByte() {
        return archiveByte;
    }

    public void setArchiveByte(byte[] archiveByte) {
        this.archiveByte = archiveByte;
    }


}
