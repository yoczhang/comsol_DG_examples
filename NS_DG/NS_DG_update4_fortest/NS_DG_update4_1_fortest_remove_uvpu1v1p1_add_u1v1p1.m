%function out = model
%
% NS_DG_update4_1_fortest_remove_uvpu1v1p1_add_u1v1p1.m
%
% Model exported on May 31 2016, 12:02 by COMSOL 5.2.0.166.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/home/yczhang/Documents/comsol_DG_examples/NS_DG/NS_DG_update4_fortest');

% model.label('NS_DG_update3.2_fortest.mph');
model.label('NS_DG_update4_1_fortest.mph');

model.comments(['NS\n\nUsing P2+P1, and Picard''s iteration']);

model.baseSystem('none');

model.param.set('nu', '1', 'dynamical viscosity');
model.param.set('sigma', '10');
model.param.set('eipsilon', '1');
model.param.set('beta', '1');

model.modelNode.create('comp1');

model.geom.create('geom1', 2);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').run;

model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').set('f1', '0');
model.variable('var2').set('f2', '0');
model.variable('var2').set('g1', '1', '(u''s)Dirichlet B.C.');
model.variable('var2').set('g2', '0');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').set('uexac', 'x^2*(x-1)^2*y*(y-1)*(2*y-1)', 'stokes exact solution');
model.variable('var3').set('vexac', '-x*(x-1)*(2*x-1)*y^2*(y-1)^2', 'stokes exact solution');
model.variable('var3').set('pexac', '(2*x-1)*(2*y-1)', 'stokes exact solution');
model.variable('var3').set('ujump', 'up(u)-down(u)');
model.variable('var3').set('vjump', 'up(v)-down(v)');
model.variable('var3').set('pjump', 'up(p)-down(p)');
model.variable('var3').set('testujump', 'test(up(u))-test(down(u))');
model.variable('var3').set('testvjump', 'test(up(v))-test(down(v))');
model.variable('var3').set('testpjump', 'test(up(p))-test(down(p))');
model.variable('var3').set('unavg', '0.5*((up(ux)+down(ux))*unx+(up(uy)+down(uy))*uny)', 'Expression:1/2*{{(ux,uy) \cdot (unx,uny)}}. Attention: the normal (unx,uny) is just using in the inter edges, (nx, ny) using in boundry edges.');
model.variable('var3').set('vnavg', '0.5*((up(vx)+down(vx))*unx+(up(vy)+down(vy))*uny)');
model.variable('var3').set('testunavg', '0.5*((test(up(ux))+test(down(ux)))*unx+(test(up(uy))+test(down(uy)))*uny)');
model.variable('var3').set('testvnavg', '0.5*((test(up(vx))+test(down(vx)))*unx+(test(up(vy))+test(down(vy)))*uny)');
model.variable('var3').set('pavg', '0.5*(up(p)+down(p))');
model.variable('var3').set('testpavg', '0.5*(test(up(p))+test(down(p)))');
model.variable('var3').set('un', 'ux*nx+uy*ny', 'un is used in boundary edges.');
model.variable('var3').set('vn', 'vx*nx+vy*ny');
model.variable('var3').set('testun', 'test(ux)*nx+test(uy)*ny', 'testun is used in boundary edges.');
model.variable('var3').set('testvn', 'test(vx)*nx+test(vy)*ny');
model.variable('var3').set('uerr', 'u-uexac');
model.variable('var3').set('verr', 'v-vexac');
model.variable('var3').set('perr', 'p-pexac');
model.variable('var3').set('u_l2err', 'sqrt(a_int(uerr^2))');
model.variable('var3').set('v_l2err', 'sqrt(a_int(verr^2))');
model.variable('var3').set('p_l2err', 'sqrt(a_int(perr^2))');
model.variable('var3').set('uv_l2err', 'sqrt(u_l2err^2+v_l2err^2)');
model.variable.create('var4');
model.variable('var4').model('comp1');
model.variable('var4').set('u1jump', 'up(u1)-down(u1)');
model.variable('var4').set('v1jump', 'up(v1)-down(v1)');
model.variable('var4').set('p1jump', 'up(p1)-down(p1)');
model.variable('var4').set('testu1jump', 'test(up(u1))-test(down(u1))');
model.variable('var4').set('testv1jump', 'test(up(v1))-test(down(v1))');
model.variable('var4').set('testp1jump', 'test(up(p1))-test(down(p1))');
model.variable('var4').set('u1navg', '0.5*((up(u1x)+down(u1x))*unx+(up(u1y)+down(u1y))*uny)', 'Expression:1/2*{{(u1x,u1y) \cdot (unx,uny)}}. Attention: the normal (unx,uny) is just using in the inter edges, (nx, ny) using in bou1ndry edges.');
model.variable('var4').set('v1navg', '0.5*((up(v1x)+down(v1x))*unx+(up(v1y)+down(v1y))*uny)');
model.variable('var4').set('testu1navg', '0.5*((test(up(u1x))+test(down(u1x)))*unx+(test(up(u1y))+test(down(u1y)))*uny)');
model.variable('var4').set('testv1navg', '0.5*((test(up(v1x))+test(down(v1x)))*unx+(test(up(v1y))+test(down(v1y)))*uny)');
model.variable('var4').set('p1avg', '0.5*(up(p1)+down(p1))');
model.variable('var4').set('testp1avg', '0.5*(test(up(p1))+test(down(p1)))');
model.variable('var4').set('u1n', 'u1x*nx+u1y*ny', 'u1n is used in bou1ndary edges.');
model.variable('var4').set('v1n', 'v1x*nx+v1y*ny');
model.variable('var4').set('testu1n', 'test(u1x)*nx+test(u1y)*ny', 'testu1n is used in bou1ndary edges.');
model.variable('var4').set('testv1n', 'test(v1x)*nx+test(v1y)*ny');
model.variable('var4').set('u1err', 'u1-ns_uexac');
model.variable('var4').set('v1err', 'v1-ns_vexac');
model.variable('var4').set('p1err', 'p1-ns_pexac');
model.variable('var4').set('u1_l2err', 'sqrt(a_int(u1err^2))');
model.variable('var4').set('v1_l2err', 'sqrt(a_int(v1err^2))');
model.variable('var4').set('p1_l2err', 'sqrt(a_int(p1err^2))');
model.variable('var4').set('u1v1_l2err', 'sqrt(u1_l2err^2+v1_l2err^2)');
model.variable.create('var5');
model.variable('var5').model('comp1');
model.variable('var5').set('u2jump', 'up(u2)-down(u2)');
model.variable('var5').set('v2jump', 'up(v2)-down(v2)');
model.variable('var5').set('p2jump', 'up(p2)-down(p2)');
model.variable('var5').set('testu2jump', 'test(up(u2))-test(down(u2))');
model.variable('var5').set('testv2jump', 'test(up(v2))-test(down(v2))');
model.variable('var5').set('testp2jump', 'test(up(p2))-test(down(p2))');
model.variable('var5').set('u2navg', '0.5*((up(u2x)+down(u2x))*unx+(up(u2y)+down(u2y))*uny)', 'Expression:1/2*{{(u2x,u2y) \cdot (unx,uny)}}. Attention: the normal (unx,uny) is just using in the inter edges, (nx, ny) using in bou2ndry edges.');
model.variable('var5').set('v2navg', '0.5*((up(v2x)+down(v2x))*unx+(up(v2y)+down(v2y))*uny)');
model.variable('var5').set('testu2navg', '0.5*((test(up(u2x))+test(down(u2x)))*unx+(test(up(u2y))+test(down(u2y)))*uny)');
model.variable('var5').set('testv2navg', '0.5*((test(up(v2x))+test(down(v2x)))*unx+(test(up(v2y))+test(down(v2y)))*uny)');
model.variable('var5').set('p2avg', '0.5*(up(p2)+down(p2))');
model.variable('var5').set('testp2avg', '0.5*(test(up(p2))+test(down(p2)))');
model.variable('var5').set('u2n', 'u2x*nx+u2y*ny', 'u2n is used in bou2ndary edges.');
model.variable('var5').set('v2n', 'v2x*nx+v2y*ny');
model.variable('var5').set('testu2n', 'test(u2x)*nx+test(u2y)*ny', 'testu2n is used in bou2ndary edges.');
model.variable('var5').set('testv2n', 'test(v2x)*nx+test(v2y)*ny');

model.view.create('view2', 2);
model.view.create('view3', 3);
model.view.create('view4', 3);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').selection.all;

model.physics.create('u_weak_func', 'WeakFormPDE', 'geom1');
model.physics('u_weak_func').identifier('u_weak_func');
model.physics('u_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('u_weak_func').feature('ibweak1').selection.all;
model.physics('u_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('u_weak_func').feature('weak1').selection.set([3]);
model.physics('u_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('u_weak_func').feature('weak2').selection.set([1 2 4]);
model.physics.create('v_weak_func', 'WeakFormPDE', 'geom1');
model.physics('v_weak_func').identifier('v_weak_func');
model.physics('v_weak_func').field('dimensionless').field('v');
model.physics('v_weak_func').field('dimensionless').component({'v'});
model.physics('v_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('v_weak_func').feature('ibweak1').selection.all;
model.physics('v_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('v_weak_func').feature('weak1').selection.set([3]);
model.physics('v_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('v_weak_func').feature('weak2').selection.set([1 2 4]);
model.physics.create('p_weak_func', 'WeakFormPDE', 'geom1');
model.physics('p_weak_func').identifier('p_weak_func');
model.physics('p_weak_func').field('dimensionless').field('p');
model.physics('p_weak_func').field('dimensionless').component({'p'});
model.physics('p_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('p_weak_func').feature('ibweak1').selection.all;
model.physics('p_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('p_weak_func').feature('weak1').selection.set([3]);
model.physics('p_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('p_weak_func').feature('weak2').selection.set([1 2 4]);
model.physics.create('u1_weak_func', 'WeakFormPDE', 'geom1');
model.physics('u1_weak_func').identifier('u1_weak_func');
model.physics('u1_weak_func').field('dimensionless').field('u1');
model.physics('u1_weak_func').field('dimensionless').component({'u1'});
model.physics('u1_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('u1_weak_func').feature('ibweak1').selection.all;
model.physics('u1_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('u1_weak_func').feature('weak1').selection.set([3]);
model.physics('u1_weak_func').create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('u1_weak_func').feature('ibweak2').selection.all;
model.physics('u1_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('u1_weak_func').feature('weak2').selection.set([3]);
model.physics('u1_weak_func').create('weak3', 'WeakContribution', 1);
model.physics('u1_weak_func').feature('weak3').selection.set([1 2 4]);
model.physics('u1_weak_func').create('weak4', 'WeakContribution', 1);
model.physics('u1_weak_func').feature('weak4').selection.set([1 2 4]);
model.physics.create('v1_weak_func', 'WeakFormPDE', 'geom1');
model.physics('v1_weak_func').identifier('v1_weak_func');
model.physics('v1_weak_func').field('dimensionless').field('v1');
model.physics('v1_weak_func').field('dimensionless').component({'v1'});
model.physics('v1_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('v1_weak_func').feature('ibweak1').selection.all;
model.physics('v1_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('v1_weak_func').feature('weak1').selection.set([3]);
model.physics('v1_weak_func').create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('v1_weak_func').feature('ibweak2').selection.all;
model.physics('v1_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('v1_weak_func').feature('weak2').selection.set([3]);
model.physics('v1_weak_func').create('weak3', 'WeakContribution', 1);
model.physics('v1_weak_func').feature('weak3').selection.set([1 2 4]);
model.physics('v1_weak_func').create('weak4', 'WeakContribution', 1);
model.physics('v1_weak_func').feature('weak4').selection.set([1 2 4]);
model.physics.create('p1_weak_func', 'WeakFormPDE', 'geom1');
model.physics('p1_weak_func').identifier('p1_weak_func');
model.physics('p1_weak_func').field('dimensionless').field('p1');
model.physics('p1_weak_func').field('dimensionless').component({'p1'});
model.physics('p1_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('p1_weak_func').feature('ibweak1').selection.all;
model.physics('p1_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('p1_weak_func').feature('weak1').selection.set([3]);
model.physics('p1_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('p1_weak_func').feature('weak2').selection.set([1 2 4]);
model.physics.create('u2_weak_func', 'WeakFormPDE', 'geom1');
model.physics('u2_weak_func').identifier('u2_weak_func');
model.physics('u2_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('u2_weak_func').feature('ibweak1').selection.all;
model.physics('u2_weak_func').create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('u2_weak_func').feature('ibweak2').selection.all;
model.physics('u2_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('u2_weak_func').feature('weak1').selection.set([3]);
model.physics('u2_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('u2_weak_func').feature('weak2').selection.set([3]);
model.physics('u2_weak_func').create('weak3', 'WeakContribution', 1);
model.physics('u2_weak_func').feature('weak3').selection.set([1 2 4]);
model.physics('u2_weak_func').create('weak4', 'WeakContribution', 1);
model.physics('u2_weak_func').feature('weak4').selection.set([1 2 4]);
model.physics.create('v2_weak_func', 'WeakFormPDE', 'geom1');
model.physics('v2_weak_func').identifier('v2_weak_func');
model.physics('v2_weak_func').field('dimensionless').field('v2');
model.physics('v2_weak_func').field('dimensionless').component({'v2'});
model.physics('v2_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('v2_weak_func').feature('ibweak1').selection.all;
model.physics('v2_weak_func').create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('v2_weak_func').feature('ibweak2').selection.all;
model.physics('v2_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('v2_weak_func').feature('weak1').selection.set([3]);
model.physics('v2_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('v2_weak_func').feature('weak2').selection.set([3]);
model.physics('v2_weak_func').create('weak3', 'WeakContribution', 1);
model.physics('v2_weak_func').feature('weak3').selection.set([1 2 4]);
model.physics('v2_weak_func').create('weak4', 'WeakContribution', 1);
model.physics('v2_weak_func').feature('weak4').selection.set([1 2 4]);
model.physics.create('p2_weak_func', 'WeakFormPDE', 'geom1');
model.physics('p2_weak_func').identifier('p2_weak_func');
model.physics('p2_weak_func').field('dimensionless').field('p2');
model.physics('p2_weak_func').field('dimensionless').component({'p2'});
model.physics('p2_weak_func').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('p2_weak_func').feature('ibweak1').selection.all;
model.physics('p2_weak_func').create('weak1', 'WeakContribution', 1);
model.physics('p2_weak_func').feature('weak1').selection.set([3]);
model.physics('p2_weak_func').create('weak2', 'WeakContribution', 1);
model.physics('p2_weak_func').feature('weak2').selection.set([1 2 4]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').create('conv1', 'Convert');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.all;

model.result.table.create('evl2', 'Table');

model.variable('var2').label('all_funs_setting');
model.variable('var3').label('stokes_init0_setting');
model.variable('var4').label('ns_step1_setting');
model.variable('var5').label('ns_step2_setting');

model.view('view1').axis.set('abstractviewxscale', '0.0020295202266424894');
model.view('view1').axis.set('ymin', '-0.0825342908501625');
model.view('view1').axis.set('xmax', '1.024999976158142');
model.view('view1').axis.set('abstractviewyscale', '0.0020295202266424894');
model.view('view1').axis.set('abstractviewbratio', '-0.04999998211860657');
model.view('view1').axis.set('abstractviewtratio', '0.04999995231628418');
model.view('view1').axis.set('abstractviewrratio', '0.39298880100250244');
model.view('view1').axis.set('xmin', '-0.024999964982271194');
model.view('view1').axis.set('abstractviewlratio', '-0.3929888904094696');
model.view('view1').axis.set('ymax', '1.0825341939926147');
model.view('view2').axis.set('ymin', '-1.3080406188964844');
model.view('view2').axis.set('xmax', '2.2925000190734863');
model.view('view2').axis.set('xmin', '-1.5924999713897705');
model.view('view2').axis.set('ymax', '1.708040714263916');

model.cpl('intop1').label('area_int');
model.cpl('intop1').set('opname', 'a_int');

model.physics('u_weak_func').label('stokes_init0_u');
model.physics('u_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('u_weak_func').feature('wfeq1').set('weak', 'nu*(ux*test(ux)+uy*test(uy))-p*test(ux)-f1*test(u)');
model.physics('u_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*ujump*testujump-nu*unavg*testujump+nu*eipsilon*testunavg*ujump+pavg*testujump*unx');
model.physics('u_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u*test(u)-nu*un*test(u)+nu*eipsilon*testun*u+p*test(u)*nx-nu*eipsilon*testun*g1-nu*sigma/h^beta*test(u)*g1');
model.physics('u_weak_func').feature('weak2').set('weakExpression', 'nu*sigma/h^beta*u*test(u)-nu*un*test(u)+nu*eipsilon*testun*u+p*test(u)*nx-nu*eipsilon*testun*0-nu*sigma/h^beta*test(u)*0');
model.physics('v_weak_func').label('stokes_init0_v');
model.physics('v_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('v_weak_func').feature('wfeq1').set('weak', 'nu*(vx*test(vx)+vy*test(vy))-p*test(vy)-f2*test(v)');
model.physics('v_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*vjump*testvjump-nu*vnavg*testvjump+nu*eipsilon*testvnavg*vjump+pavg*testvjump*uny');
model.physics('v_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*v*test(v)-nu*vn*test(v)+nu*eipsilon*testvn*v+p*test(v)*ny-nu*eipsilon*testvn*g1-nu*sigma/h^beta*test(v)*g2');
model.physics('v_weak_func').feature('weak2').set('weakExpression', 'nu*sigma/h^beta*v*test(v)-nu*vn*test(v)+nu*eipsilon*testvn*v+p*test(v)*ny-nu*eipsilon*testvn*0-nu*sigma/h^beta*test(v)*0');
model.physics('p_weak_func').label('stokes_init0_p');
model.physics('p_weak_func').prop('ShapeProperty').set('order', '1');
model.physics('p_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('p_weak_func').feature('wfeq1').set('weak', '-test(p)*(ux+vy)+test(p)*p*1e-6');
model.physics('p_weak_func').feature('ibweak1').set('weakExpression', 'testpavg*(ujump*unx+vjump*uny)');
model.physics('p_weak_func').feature('weak1').set('weakExpression', 'test(p)*(u*nx+v*ny)-test(p)*(g1*nx+g2*ny)');
model.physics('p_weak_func').feature('weak2').set('weakExpression', 'test(p)*(u*nx+v*ny)-test(p)*(0*nx+0*ny)');
model.physics('u1_weak_func').label('ns_step1_u1');
model.physics('u1_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('u1_weak_func').feature('wfeq1').set('weak', 'nu*(u1x*test(u1x)+u1y*test(u1y))+(u*u1x+v*u1y)*test(u1)+0.5*(ux+vy)*u1*test(u1)-p1*test(u1x)-f1*test(u1)');
model.physics('u1_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*u1jump*testu1jump-nu*u1navg*testu1jump+nu*eipsilon*testu1navg*u1jump+p1avg*testu1jump*unx');
model.physics('u1_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u1*test(u1)-nu*u1n*test(u1)+nu*eipsilon*testu1n*u1+p1*test(u1)*nx-nu*eipsilon*testu1n*g1-nu*sigma/h^beta*test(u1)*g1');
model.physics('u1_weak_func').feature('ibweak2').set('weakExpression', '(u*dnx+v*dny<0)*(u*dnx+v*dny)*test(down(u1))*(down(u1)-up(u1))+(u*unx+v*uny<0)*(u*unx+v*uny)*test(up(u1))*(up(u1)-down(u1))-0.5*(ujump*unx+vjump*uny)*(0.5*(up(u1*test(u1))+down(u1*test(u1))))');
model.physics('u1_weak_func').feature('weak2').set('weakExpression', '(u*dnx+v*dny<0)*(u*dnx+v*dny)*test(down(u1))*(down(u1)-g1)+(u*unx+v*uny<0)*(u*unx+v*uny)*test(up(u1))*(up(u1)-g1)-0.5*(u*nx+v*ny)*(u1*test(u1))');
model.physics('u1_weak_func').feature('weak3').set('weakExpression', 'nu*sigma/h^beta*u1*test(u1)-nu*u1n*test(u1)+nu*eipsilon*testu1n*u1+p1*test(u1)*nx-nu*eipsilon*testu1n*0-nu*sigma/h^beta*test(u1)*0');
model.physics('u1_weak_func').feature('weak4').set('weakExpression', '(u*dnx+v*dny<0)*(u*dnx+v*dny)*test(down(u1))*(down(u1)-0)+(u*unx+v*uny<0)*(u*unx+v*uny)*test(up(u1))*(up(u1)-0)-0.5*(u*nx+v*ny)*(u1*test(u1))');
model.physics('v1_weak_func').label('ns_step1_v1');
model.physics('v1_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('v1_weak_func').feature('wfeq1').set('weak', 'nu*(v1x*test(v1x)+v1y*test(v1y))+(u*v1x+v*v1y)*test(v1)+0.5*(ux+vy)*v1*test(v1)-p1*test(v1y)-f2*test(v1)');
model.physics('v1_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*v1jump*testv1jump-nu*v1navg*testv1jump+nu*eipsilon*testv1navg*v1jump+p1avg*testv1jump*uny');
model.physics('v1_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*v1*test(v1)-nu*v1n*test(v1)+nu*eipsilon*testv1n*v1+p1*test(v1)*ny-nu*eipsilon*testv1n*g1-nu*sigma/h^beta*test(v1)*g2');
model.physics('v1_weak_func').feature('ibweak2').set('weakExpression', '(u*dnx+v*dny<0)*(u*dnx+v*dny)*test(down(v1))*(down(v1)-up(v1))+(u*unx+v*uny<0)*(u*unx+v*uny)*test(up(v1))*(up(v1)-down(v1))-0.5*(ujump*unx+vjump*uny)*(0.5*(up(v1*test(v1))+down(v1*test(v1))))');
model.physics('v1_weak_func').feature('weak2').set('weakExpression', '(u*dnx+v*dny<0)*(u*dnx+v*dny)*test(down(v1))*(down(v1)-g2)+(u*unx+v*uny<0)*(u*unx+v*uny)*test(up(v1))*(up(v1)-g2)-0.5*(u*nx+v*ny)*(v1*test(v1))');
model.physics('v1_weak_func').feature('weak3').set('weakExpression', 'nu*sigma/h^beta*v1*test(v1)-nu*v1n*test(v1)+nu*eipsilon*testv1n*v1+p1*test(v1)*ny-nu*eipsilon*testv1n*0-nu*sigma/h^beta*test(v1)*0');
model.physics('v1_weak_func').feature('weak4').set('weakExpression', '(u*dnx+v*dny<0)*(u*dnx+v*dny)*test(down(v1))*(down(v1)-0)+(u*unx+v*uny<0)*(u*unx+v*uny)*test(up(v1))*(up(v1)-0)-0.5*(u*nx+v*ny)*(v1*test(v1))');
model.physics('p1_weak_func').label('ns_step1_p1');
model.physics('p1_weak_func').prop('ShapeProperty').set('order', '1');
model.physics('p1_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('p1_weak_func').feature('wfeq1').set('weak', '-test(p1)*(u1x+v1y)+test(p1)*p1*1e-6');
model.physics('p1_weak_func').feature('ibweak1').set('weakExpression', 'testp1avg*(u1jump*unx+v1jump*uny)');
model.physics('p1_weak_func').feature('weak1').set('weakExpression', 'test(p1)*(u1*nx+v1*ny)-test(p1)*(g1*nx+g2*ny)');
model.physics('p1_weak_func').feature('weak2').set('weakExpression', 'test(p1)*(u1*nx+v1*ny)-test(p1)*(0*nx+0*ny)');
model.physics('u2_weak_func').label('ns_step2_u2');
model.physics('u2_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('u2_weak_func').feature('wfeq1').set('weak', 'nu*(u2x*test(u2x)+u2y*test(u2y))+(u1*u2x+v1*u2y)*test(u2)+0.5*(u1x+v1y)*u2*test(u2)-p2*test(u2x)-f1*test(u2)');
model.physics('u2_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*u2jump*testu2jump-nu*u2navg*testu2jump+nu*eipsilon*testu2navg*u2jump+p2avg*testu2jump*unx');
model.physics('u2_weak_func').feature('ibweak2').set('weakExpression', '(u1*dnx+v1*dny<0)*(u1*dnx+v1*dny)*test(down(u2))*(down(u2)-up(u2))+(u1*unx+v1*uny<0)*(u1*unx+v1*uny)*test(up(u2))*(up(u2)-down(u2))-0.5*(u1jump*unx+v1jump*uny)*(0.5*(up(u2*test(u2))+down(u2*test(u2))))');
model.physics('u2_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u2*test(u2)-nu*u2n*test(u2)+nu*eipsilon*testu2n*u2+p2*test(u2)*nx-nu*eipsilon*testu2n*g1-nu*sigma/h^beta*test(u2)*g1');
model.physics('u2_weak_func').feature('weak2').set('weakExpression', '(u1*dnx+v1*dny<0)*(u1*dnx+v1*dny)*test(down(u2))*(down(u2)-g1)+(u1*unx+v1*uny<0)*(u1*unx+v1*uny)*test(up(u2))*(up(u2)-g1)-0.5*(u1*nx+v1*ny)*(u2*test(u2))');
model.physics('u2_weak_func').feature('weak3').set('weakExpression', 'nu*sigma/h^beta*u2*test(u2)-nu*u2n*test(u2)+nu*eipsilon*testu2n*u2+p2*test(u2)*nx-nu*eipsilon*testu2n*0-nu*sigma/h^beta*test(u2)*0');
model.physics('u2_weak_func').feature('weak4').set('weakExpression', '(u1*dnx+v1*dny<0)*(u1*dnx+v1*dny)*test(down(u2))*(down(u2)-0)+(u1*unx+v1*uny<0)*(u1*unx+v1*uny)*test(up(u2))*(up(u2)-0)-0.5*(u1*nx+v1*ny)*(u2*test(u2))');
model.physics('v2_weak_func').label('ns_step2_v2');
model.physics('v2_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('v2_weak_func').feature('wfeq1').set('weak', 'nu*(v2x*test(v2x)+v2y*test(v2y))+(u1*v2x+v1*v2y)*test(v2)+0.5*(u1x+v1y)*v2*test(v2)-p2*test(v2y)-f2*test(v2)');
model.physics('v2_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*v2jump*testv2jump-nu*v2navg*testv2jump+nu*eipsilon*testv2navg*v2jump+p2avg*testv2jump*uny');
model.physics('v2_weak_func').feature('ibweak2').set('weakExpression', '(u1*dnx+v1*dny<0)*(u1*dnx+v1*dny)*test(down(v2))*(down(v2)-up(v2))+(u1*unx+v1*uny<0)*(u1*unx+v1*uny)*test(up(v2))*(up(v2)-down(v2))-0.5*(u1jump*unx+v1jump*uny)*(0.5*(up(v2*test(v2))+down(v2*test(v2))))');
model.physics('v2_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*v2*test(v2)-nu*v2n*test(v2)+nu*eipsilon*testv2n*v2+p2*test(v2)*ny-nu*eipsilon*testv2n*g1-nu*sigma/h^beta*test(v2)*g2');
model.physics('v2_weak_func').feature('weak2').set('weakExpression', '(u1*dnx+v1*dny<0)*(u1*dnx+v1*dny)*test(down(v2))*(down(v2)-g2)+(u1*unx+v1*uny<0)*(u1*unx+v1*uny)*test(up(v2))*(up(v2)-g2)-0.5*(u1*nx+v1*ny)*(v2*test(v2))');
model.physics('v2_weak_func').feature('weak3').set('weakExpression', 'nu*sigma/h^beta*v2*test(v2)-nu*v2n*test(v2)+nu*eipsilon*testv2n*v2+p2*test(v2)*ny-nu*eipsilon*testv2n*0-nu*sigma/h^beta*test(v2)*0');
model.physics('v2_weak_func').feature('weak4').set('weakExpression', '(u1*dnx+v1*dny<0)*(u1*dnx+v1*dny)*test(down(v2))*(down(v2)-0)+(u1*unx+v1*uny<0)*(u1*unx+v1*uny)*test(up(v2))*(up(v2)-0)-0.5*(u1*nx+v1*ny)*(v2*test(v2))');
model.physics('p2_weak_func').label('ns_step2_p2');
model.physics('p2_weak_func').prop('ShapeProperty').set('order', '1');
model.physics('p2_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('p2_weak_func').feature('wfeq1').set('weak', '-test(p2)*(u2x+v2y)+test(p2)*p2*1e-6');
model.physics('p2_weak_func').feature('ibweak1').set('weakExpression', 'testp2avg*(u2jump*unx+v2jump*uny)');
model.physics('p2_weak_func').feature('weak1').set('weakExpression', 'test(p2)*(u2*nx+v2*ny)-test(p2)*(g1*nx+g2*ny)');
model.physics('p2_weak_func').feature('weak2').set('weakExpression', 'test(p2)*(u2*nx+v2*ny)-test(p2)*(0*nx+0*ny)');

model.mesh('mesh1').feature('size').set('custom', 'on');
model.mesh('mesh1').feature('size').set('hmax', '1/32');
model.mesh('mesh1').feature('map1').set('adjustedgdistr', true);
model.mesh('mesh1').run;

model.frame('material1').sorder(1);

model.result.table('evl2').label('Evaluation 2D');
model.result.table('evl2').comments([native2unicode(hex2dec({'4e' 'a4'}), 'unicode')  native2unicode(hex2dec({'4e' '92'}), 'unicode')  native2unicode(hex2dec({'76' '84'}), 'unicode')  native2unicode(hex2dec({'4e' '8c'}), 'unicode')  native2unicode(hex2dec({'7e' 'f4'}), 'unicode')  native2unicode(hex2dec({'50' '3c'}), 'unicode') ]);

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('activate', {'u_weak_func' 'on' 'v_weak_func' 'on' 'p_weak_func' 'on' 'u1_weak_func' 'off' 'v1_weak_func' 'off'  ...
'p1_weak_func' 'off' 'u2_weak_func' 'off' 'v2_weak_func' 'off' 'p2_weak_func' 'off'});
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').set('activate', {'u_weak_func' 'off' 'v_weak_func' 'off' 'p_weak_func' 'off' 'u1_weak_func' 'on' 'v1_weak_func' 'on'  ...
'p1_weak_func' 'on' 'u2_weak_func' 'off' 'v2_weak_func' 'off' 'p2_weak_func' 'off'});
model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').set('activate', {'u_weak_func' 'off' 'v_weak_func' 'off' 'p_weak_func' 'off' 'u1_weak_func' 'off' 'v1_weak_func' 'off'  ...
'p1_weak_func' 'off' 'u2_weak_func' 'on' 'v2_weak_func' 'on' 'p2_weak_func' 'on'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').attach('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').attach('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature.remove('fcDef');

model.result.create('pg1', 'PlotGroup2D');
model.result.create('pg2', 'PlotGroup2D');
model.result.create('pg3', 'PlotGroup2D');
model.result.create('pg4', 'PlotGroup2D');
model.result.create('pg5', 'PlotGroup2D');
model.result.create('pg6', 'PlotGroup2D');
model.result.create('pg7', 'PlotGroup2D');
model.result.create('pg8', 'PlotGroup2D');
model.result.create('pg9', 'PlotGroup2D');
model.result('pg1').create('surf1', 'Surface');
model.result('pg2').create('surf1', 'Surface');
model.result('pg3').create('surf1', 'Surface');
model.result('pg4').set('data', 'dset2');
model.result('pg4').create('surf1', 'Surface');
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('surf1', 'Surface');
model.result('pg6').set('data', 'dset2');
model.result('pg6').create('surf1', 'Surface');
model.result('pg7').set('data', 'dset3');
model.result('pg7').create('surf1', 'Surface');
model.result('pg8').set('data', 'dset3');
model.result('pg8').create('surf1', 'Surface');
model.result('pg9').set('data', 'dset3');
model.result('pg9').create('surf1', 'Surface');

model.study('std1').label('solve_stokes_init0_uvp');
model.study('std2').label('solve_ns_step1_u1v1p1');
model.study('std3').label('solve_ns_step2_u2v2p2');

model.sol('sol1').attach('std1');
model.sol('sol1').runAll;
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result('pg2').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' v']);
model.result('pg2').feature('surf1').set('expr', 'v');
model.result('pg3').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' p']);
model.result('pg3').feature('surf1').set('expr', 'p');
model.result('pg4').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' u1']);
model.result('pg4').feature('surf1').set('expr', 'u1');
model.result('pg5').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' v1']);
model.result('pg5').feature('surf1').set('expr', 'v1');
model.result('pg6').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' p1']);
model.result('pg6').feature('surf1').set('expr', 'p1');
model.result('pg7').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' u2']);
model.result('pg7').feature('surf1').set('expr', 'u2');
model.result('pg8').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' v2']);
model.result('pg8').feature('surf1').set('expr', 'v2');
model.result('pg9').feature('surf1').set('descr', [native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' p2']);
model.result('pg9').feature('surf1').set('expr', 'p2');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg5').run;
model.result('pg4').run;
model.result('pg2').run;
model.result('pg5').run;
model.result('pg8').run;
model.result('pg3').run;
model.result('pg6').run;
model.result('pg9').run;
model.result('pg6').run;
model.result('pg9').run;
model.result('pg3').run;
model.result('pg9').run;


model.physics.remove('u_weak_func');
model.physics.remove('v_weak_func');
model.physics.remove('p_weak_func');

model.study.remove('std1');

model.physics.remove('u1_weak_func');
model.physics.remove('v1_weak_func');
model.physics.remove('p1_weak_func');

model.study.remove('std2');


%% next is adding u1 func
model.physics.create('w', 'WeakFormPDE', 'geom1', {'u'});

model.study('std3').feature('stat').activate('w', true);

model.physics('w').label('ns_step2_u1');
model.physics('w').tag('u1_weak_func');
model.physics('u1_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('u1_weak_func').field('dimensionless').field('u1');
model.physics('u1_weak_func').field('dimensionless').component(1, 'u1');
model.physics('u1_weak_func').feature.create('ibweak1', 'InteriorBoundaryContribution', 2); % 'ibweak' standsfor 'interior boundary weak'
model.physics('u1_weak_func').feature.create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('u1_weak_func').feature('wfeq1').setIndex('weak', 'nu*(u1x*test(u1x)+u1y*test(u1y))+(u2*u1x+v2*u1y)*test(u1)+0.5*(u2x+v2y)*u1*test(u1)-p1*test(u1x)-f1*test(u1)', 0); % 'wfeq' standsfor 'weakform equation'
model.physics('u1_weak_func').feature('ibweak1').selection.set([]);
model.physics('u1_weak_func').feature('ibweak1').selection.all;
model.physics('u1_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*u1jump*testu1jump-nu*u1navg*testu1jump+nu*eipsilon*testu1navg*u1jump+p1avg*testu1jump*unx');
model.physics('u1_weak_func').feature('ibweak2').selection.all;
model.physics('u1_weak_func').feature('ibweak2').set('weakExpression', '(u2*dnx+v2*dny<0)*(u2*dnx+v2*dny)*test(down(u1))*(down(u1)-up(u1))+(u2*unx+v2*uny<0)*(u2*unx+v2*uny)*test(up(u1))*(up(u1)-down(u1))-0.5*(u2jump*unx+v2jump*uny)*(0.5*(up(u1*test(u1))+down(u1*test(u1))))');
model.physics('u1_weak_func').feature.create('weak1', 'WeakContribution', 1);
model.physics('u1_weak_func').feature.create('weak2', 'WeakContribution', 1);
model.physics('u1_weak_func').feature.create('weak3', 'WeakContribution', 1);
model.physics('u1_weak_func').feature.create('weak4', 'WeakContribution', 1);
model.physics('u1_weak_func').feature('weak1').selection.set([3]);
model.physics('u1_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u1*test(u1)-nu*u1n*test(u1)+nu*eipsilon*testu1n*u1+p1*test(u1)*nx-nu*eipsilon*testu1n*g1-nu*sigma/h^beta*test(u1)*g1');
model.physics('u1_weak_func').feature('weak2').selection.set([3]);
model.physics('u1_weak_func').feature('weak2').set('weakExpression', '(u2*dnx+v2*dny<0)*(u2*dnx+v2*dny)*test(down(u1))*(down(u1)-g1)+(u2*unx+v2*uny<0)*(u2*unx+v2*uny)*test(up(u1))*(up(u1)-g1)-0.5*(u2*nx+v2*ny)*(u1*test(u1))');
model.physics('u1_weak_func').feature('weak3').selection.all;
model.physics('u1_weak_func').feature('weak3').selection.set([1 2 4]);
model.physics('u1_weak_func').feature('weak3').set('weakExpression', 'nu*sigma/h^beta*u1*test(u1)-nu*u1n*test(u1)+nu*eipsilon*testu1n*u1+p1*test(u1)*nx-nu*eipsilon*testu1n*0-nu*sigma/h^beta*test(u1)*0');
model.physics('u1_weak_func').feature('weak4').selection.all;
model.physics('u1_weak_func').feature('weak4').selection.set([1 2 4]);
model.physics('u1_weak_func').feature('weak4').set('weakExpression', '(u2*dnx+v2*dny<0)*(u2*dnx+v2*dny)*test(down(u1))*(down(u1)-0)+(u2*unx+v2*uny<0)*(u2*unx+v2*uny)*test(up(u1))*(up(u1)-0)-0.5*(u2*nx+v2*ny)*(u1*test(u1))');

%% next is adding v1 func
model.physics.create('w2', 'WeakFormPDE', 'geom1', {'v1'});

model.study('std3').feature('stat').activate('w2', false);

model.physics('w2').field('dimensionless').field('v1');
model.physics('w2').identifier('w2');
model.physics('w2').label('ns_step2_v1');
model.physics('w2').tag('v1_weak_func');
model.physics('v1_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('v1_weak_func').feature.create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('v1_weak_func').feature.create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('v1_weak_func').feature('wfeq1').setIndex('weak', 'nu*(v1x*test(v1x)+v1y*test(v1y))+(u2*v1x+v2*v1y)*test(v1)+0.5*(u2x+v2y)*v1*test(v1)-p1*test(v1y)-f2*test(v1)', 0);
model.physics('v1_weak_func').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*v1jump*testv1jump-nu*v1navg*testv1jump+nu*eipsilon*testv1navg*v1jump+p1avg*testv1jump*uny');
model.physics('v1_weak_func').feature('ibweak1').selection.all;
model.physics('v1_weak_func').feature('ibweak2').selection.all;
model.physics('v1_weak_func').feature('ibweak2').set('weakExpression', '(u2*dnx+v2*dny<0)*(u2*dnx+v2*dny)*test(down(v1))*(down(v1)-up(v1))+(u2*unx+v2*uny<0)*(u2*unx+v2*uny)*test(up(v1))*(up(v1)-down(v1))-0.5*(u2jump*unx+v2jump*uny)*(0.5*(up(v1*test(v1))+down(v1*test(v1))))');
model.physics('v1_weak_func').feature.create('weak1', 'WeakContribution', 1);
model.physics('v1_weak_func').feature.create('weak2', 'WeakContribution', 1);
model.physics('v1_weak_func').feature.create('weak3', 'WeakContribution', 1);
model.physics('v1_weak_func').feature.create('weak4', 'WeakContribution', 1);
model.physics('v1_weak_func').feature('weak1').selection.set([3]);
model.physics('v1_weak_func').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*v1*test(v1)-nu*v1n*test(v1)+nu*eipsilon*testv1n*v1+p1*test(v1)*ny-nu*eipsilon*testv1n*g2-nu*sigma/h^beta*test(v1)*g2');
model.physics('v1_weak_func').feature('weak2').selection.set([3]);
model.physics('v1_weak_func').feature('weak2').set('weakExpression', '(u2*dnx+v2*dny<0)*(u2*dnx+v2*dny)*test(down(v1))*(down(v1)-g2)+(u2*unx+v2*uny<0)*(u2*unx+v2*uny)*test(up(v1))*(up(v1)-g2)-0.5*(u2*nx+v2*ny)*(v1*test(v1))');
model.physics('v1_weak_func').feature('weak3').selection.all;
model.physics('v1_weak_func').feature('weak3').selection.set([1 2 4]);
model.physics('v1_weak_func').feature('weak3').set('weakExpression', 'nu*sigma/h^beta*v1*test(v1)-nu*v1n*test(v1)+nu*eipsilon*testv1n*v1+p1*test(v1)*ny-nu*eipsilon*testv1n*0-nu*sigma/h^beta*test(v1)*0');
model.physics('v1_weak_func').feature('weak4').selection.all;
model.physics('v1_weak_func').feature('weak4').selection.set([1 2 4]);
model.physics('v1_weak_func').feature('weak4').set('weakExpression', '(u2*dnx+v2*dny<0)*(u2*dnx+v2*dny)*test(down(v1))*(down(v1)-0)+(u2*unx+v2*uny<0)*(u2*unx+v2*uny)*test(up(v1))*(up(v1)-0)-0.5*(u2*nx+v2*ny)*(v1*test(v1))');


%% next is adding p1 func
model.physics.create('w', 'WeakFormPDE', 'geom1', {'p1'});

model.study('std3').feature('stat').activate('w', false);

model.physics('w').field('dimensionless').field('p1');
model.physics('w').selection.set([1]);
model.physics('w').label('ns_step2_p1');
model.physics('w').tag('p1_weak_func');
model.physics('p1_weak_func').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('p1_weak_func').prop('ShapeProperty').set('order', '1');
model.physics('p1_weak_func').feature.create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('p1_weak_func').feature('wfeq1').setIndex('weak', '-test(p1)*(u1x+v1y)+test(p1)*p1*1e-6', 0);
model.physics('p1_weak_func').feature('ibweak1').set('weakExpression', 'testp1avg*(u1jump*unx+v1jump*uny)');
model.physics('p1_weak_func').feature.create('weak1', 'WeakContribution', 1);
model.physics('p1_weak_func').feature.create('weak2', 'WeakContribution', 1);
model.physics('p1_weak_func').feature('weak1').selection.set([3]);
model.physics('p1_weak_func').feature('weak1').set('weakExpression', 'test(p1)*(u1*nx+v1*ny)-test(p1)*(g1*nx+g2*ny)');
model.physics('p1_weak_func').feature('weak2').selection.all;
model.physics('p1_weak_func').feature('weak2').selection.set([1 2 4]);
model.physics('p1_weak_func').feature('weak2').set('weakExpression', 'test(p1)*(u1*nx+v1*ny)-test(p1)*(0*nx+0*ny)');
model.physics('p1_weak_func').feature('ibweak1').selection.all;


%% next is adding study
model.study.create('std4');
model.study('std4').create('stat', 'Stationary');
model.study('std4').feature('stat').activate('u2_weak_func', false);
model.study('std4').feature('stat').activate('v2_weak_func', false);
model.study('std4').feature('stat').activate('p2_weak_func', false);
model.study('std4').feature('stat').activate('u1_weak_func', true);
model.study('std4').feature('stat').activate('v1_weak_func', true);
model.study('std4').feature('stat').activate('p1_weak_func', true);
model.study('std4').feature('stat').set('showdistribute', true);
%model.study('std4').feature('stat').label('solve_ns_step2_u1v1p1');
model.study('std4').feature('stat').set('showdistribute', true);
model.study('std4').label('solve_ns_step2_u1v1p1');
model.study('std4').feature('stat').set('showdistribute', true);
model.study('std4').feature('stat').label([native2unicode(hex2dec({'7a' '33'}), 'unicode')  native2unicode(hex2dec({'60' '01'}), 'unicode') ]);


model.sol.create('sol4');
model.sol('sol4').study('std4');

model.study('std4').feature('stat').set('notlistsolnum', 1);
model.study('std4').feature('stat').set('notsolnum', '1');
model.study('std4').feature('stat').set('listsolnum', 1);
model.study('std4').feature('stat').set('solnum', '1');

model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').feature('s1').create('seDef', 'Segregated');
model.sol('sol4').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol4').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol4').feature('s1').feature.remove('fcDef');
model.sol('sol4').feature('s1').feature.remove('seDef');
model.sol('sol4').attach('std4');

model.result.create('pg10', 2);
model.result('pg10').set('data', 'dset4');
model.result('pg10').create('surf1', 'Surface');
model.result('pg10').feature('surf1').set('expr', 'u1');
model.result.create('pg11', 2);
model.result('pg11').set('data', 'dset4');
model.result('pg11').create('surf1', 'Surface');
model.result('pg11').feature('surf1').set('expr', 'v1');
model.result.create('pg12', 2);
model.result('pg12').set('data', 'dset4');
model.result('pg12').create('surf1', 'Surface');
model.result('pg12').feature('surf1').set('expr', 'p1');

model.sol('sol4').runAll;

model.result('pg10').run;

%out = model;
